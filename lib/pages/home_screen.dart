import 'package:face_net_authentication/components/custom_graphs.dart';
import 'package:face_net_authentication/components/slider.dart';
import 'package:face_net_authentication/constants/colors.dart';
import 'package:face_net_authentication/constants/enums.dart';
import 'package:face_net_authentication/constants/static_data.dart';
import 'package:face_net_authentication/pages/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  final LinearGradient _gradient = LinearGradient(
      begin: Alignment(-1, -1),
      end: Alignment(1, 1),
      colors: [appPurple, appMagenta, appLightBlue]);

  List<double> sliderValue = [9.6, 1.2, 0.52];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      width: size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(payrollSelectors.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: appGrey, width: 2)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 20),
                                  child: Text(payrollSelectors[index],
                                      style: TextStyle(
                                          color: appGrey,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            );
                          })),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Paycheck preferences",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: size.height * 0.18,
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Paycheck is",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "\$48,850.15",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: _gradient)),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Charts",
                          style: TextStyle(
                              color: appGrey, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(color: appPurple),
                        )
                      ],
                    ),
                    SizedBox(
                      width: size.width,
                      child: SingleChildScrollView(
                          child: Column(
                        children: List.generate(3, (index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                            color: payrollColor[index],
                                            maxValue: coinValue[index],
                                            name: coinNames[index],
                                          )));
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: payrollColor[index]
                                              .withOpacity(0.3)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Image.asset(coinIcons[index]),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(coinShort[index],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Text(
                                            (sliderValue[index] * 10)
                                                    .toStringAsFixed(1) +
                                                "%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.3,
                                      height: size.height * 0.06,
                                      child: customGraphs(
                                        graphColor: payrollColor[index],
                                        showLeftTile: false,
                                        maxValue: coinValue[index],
                                        graphInterval: GraphInterval.Day,
                                      ),
                                    ),
                                    Text(payrollValue[index])
                                  ],
                                ),
                                StatefulBuilder(
                                    builder: (context, sliderState) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (sliderValue[index] > 0) {
                                              sliderValue[index] =
                                                  sliderValue[index] - 1;
                                              sliderState(() {});
                                            }
                                          },
                                          child: Icon(
                                            CupertinoIcons.minus,
                                            size: 18,
                                          )),
                                      SizedBox(
                                        width: size.width * 0.8,
                                        child: CustomSlider(
                                            gradient: _gradient,
                                            value: sliderValue[index],
                                            onChange: (x) {
                                              sliderState(() {
                                                sliderValue[index] = x;
                                              });
                                            }),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            if (sliderValue[index] < 10) {
                                              sliderValue[index] =
                                                  sliderValue[index] + 1;
                                              sliderState(() {});
                                            }
                                          },
                                          child: Icon(
                                            CupertinoIcons.add,
                                            size: 18,
                                          )),
                                    ],
                                  );
                                }),
                                Divider(),
                              ],
                            ),
                          );
                        }),
                      )),
                    )
                  ],
                ),
              ),
            )));
  }
}
