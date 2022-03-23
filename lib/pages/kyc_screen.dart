import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:face_net_authentication/components/custom_app_bar.dart';
import 'package:face_net_authentication/constants/lottie_strings.dart';
import 'package:face_net_authentication/constants/strings.dart';
import 'package:face_net_authentication/services/camera.service.dart';
import 'package:face_net_authentication/services/face_detector_service.dart';
import 'package:face_net_authentication/services/ml_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum KYCState { First, Second, Selfie }

class KycScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KycScreenState();
  }
}

class _KycScreenState extends State<KycScreen> {
  final CameraService _cameraService = CameraService();

  bool isLoading = false;

  List modalData = [];
  List predictedData = [];

  bool isBack = true;

  KYCState kycState = KYCState.First;

  XFile? tempImage;

  bool? isResult;

  @override
  void initState() {
    super.initState();
    _cameraService.initialize(true).then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_cameraService.cameraController == null) {
      return Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: kycScreenAppBar(title: kycState == KYCState.First
          ? firstIdString
          : kycState == KYCState.Second
          ? secondIdString
          : selfieId, context: context),

        body: isResult != null ? kycCompleteWidget(isResult!) : kycWidget());
  }

  Widget kycWidget() {
    Size size = MediaQuery.of(context).size;

    final deviceRatio = size.width / (size.height * 0.36);

    return Stack(
      children: [
        Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.1),
                  child: SizedBox(
                      height: size.height * 0.36,
                      width: size.width,
                      child: kycState == KYCState.Selfie
                          ? tempImage == null
                              ? AspectRatio(
                                  aspectRatio: 1 / 0.7,
                                  child: ClipRect(
                                    child: Transform.scale(
                                        scale: _cameraService.cameraController!
                                                .value.aspectRatio /
                                            0.7,
                                        child: Center(
                                          child: CameraPreview(
                                              _cameraService.cameraController!),
                                        )),
                                  ),
                                )
                              : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: Container(
                                    color: Colors.white,
                                    child: Image.file(
                                      File(tempImage!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                          : Stack(
                              fit: StackFit.expand,
                              children: [
                                tempImage == null
                                    ? AspectRatio(
                                        aspectRatio: 1 / 0.7,
                                        child: ClipRect(
                                          child: Transform.scale(
                                            scale: _cameraService
                                                    .cameraController!
                                                    .value
                                                    .aspectRatio /
                                                0.7,
                                            child: Center(
                                              child: CameraPreview(
                                                  _cameraService
                                                      .cameraController!),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        color: Colors.white,
                                        child: Image.file(
                                          File(tempImage!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                cameraOverlay(
                                    padding: 50,
                                    aspectRatio: 1,
                                    color: Color(0x55000000))
                              ],
                            )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    kycState == KYCState.First
                        ? firstIdString
                        : kycState == KYCState.Second
                            ? secondIdString
                            : selfieId,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text(
                    kycState == KYCState.Selfie
                        ? selfieBody
                        : kycState == KYCState.First
                            ? firstIdBodyString
                            : secondIdBodyString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            print("method called");
                            await _cameraService.initialize(!isBack);
                            setState(() {
                              isBack = !isBack;
                              isLoading = false;
                            });
                          },
                          icon: Icon(Icons.flip_camera_android_outlined,
                              color: Colors.white, size: 30)),
                      TextButton(
                        onPressed: () async {
                          if (tempImage != null) {
                            tempImage = null;
                            if (kycState == KYCState.First) {
                              modalData = [];
                            }
                            setState(() {});
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            tempImage = await _cameraService.cameraController!
                                .takePicture();
                            if (kycState == KYCState.Selfie) {
                              analyse();
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: Text(tempImage == null ? "Capture" : "Retake",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                      if (kycState != KYCState.Selfie)
                        TextButton(
                          onPressed: () async {
                            if (tempImage == null) {
                              return;
                            }
                            if (kycState == KYCState.Second) {
                              await _cameraService.initialize(false);
                              isBack = false;
                              kycState = KYCState.Selfie;
                              setState(() {
                                tempImage = null;
                              });
                            } else {
                              analyse();
                            }
                          },
                          child: Text("Next",
                              style: TextStyle(
                                  color: tempImage == null
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                    ],
                  ),
                )
              ],
            )),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
      ],
    );
  }

  Future<void> analyse() async {
    setState(() {
      isLoading = true;
    });
    try {
      FaceDetectorService faceDetectorService = FaceDetectorService();
      faceDetectorService.initialize();
      await faceDetectorService.detectFacesFromImage(tempImage!);

      if (modalData.isEmpty) {
        MLService mlService = MLService();
        await mlService.initialize();
        modalData = await mlService.setCurrentPrediction(
            tempImage!, faceDetectorService.faces[0]);
      } else {
        MLService mlService = MLService();
        await mlService.initialize();
        predictedData = await mlService.setCurrentPrediction(
            tempImage!, faceDetectorService.faces[0]);
        final result = await mlService.predict(modalData, predictedData);
        print("--------------------- Prediction Result --------------------");
        print(result);
        modalData = [];
        predictedData = [];
        isResult = result;
      }
      switch (kycState) {
        case KYCState.First:
          kycState = KYCState.Second;
          await _cameraService.initialize(true);
          tempImage = null;
          break;
        case KYCState.Second:
          kycState = KYCState.Selfie;
          await _cameraService.initialize(false);
          isBack = false;
          tempImage = null;
          break;
        case KYCState.Selfie:
          kycState = KYCState.Selfie;
          break;
      }
    } catch (error) {
      print(error);
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget kycCompleteWidget(bool result) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Lottie.asset(result ? successLottie : failureLottie),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                result
                    ? "Your face matched your ID. KYC is completed"
                    : "Your face didn't matched your ID. Please retry with valid ID.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal)),
          ),
          TextButton(
            onPressed: () async {
              await _cameraService.initialize(true);
              setState(() {
                tempImage = null;
                modalData = [];
                predictedData = [];
                kycState = KYCState.First;
                isResult = null;
                isBack = true;
              });
            },
            child: Text("Retake KYC",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget cameraOverlay(
      {required double padding,
      required double aspectRatio,
      required Color color}) {
    return LayoutBuilder(builder: (context, constraints) {
      double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
      double horizontalPadding;
      double verticalPadding;

      if (parentAspectRatio < aspectRatio) {
        horizontalPadding = padding / 4;
        verticalPadding = (constraints.maxHeight -
                ((constraints.maxWidth - 2 * padding) / aspectRatio)) /
            2;
      } else {
        verticalPadding = padding * 0.7;
        horizontalPadding = (constraints.maxWidth -
                ((constraints.maxHeight - 2 * padding) * aspectRatio)) /
            9;
      }
      return Stack(fit: StackFit.expand, children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.centerRight,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
        )
      ]);
    });
  }
}
