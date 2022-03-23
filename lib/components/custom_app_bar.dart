import 'dart:io';

import 'package:face_net_authentication/constants/colors.dart';
import 'package:flutter/material.dart';

detailsScreenAppBar(
    {required String title,
    required BuildContext context,
    required Color color}) {
  if (Platform.isAndroid) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title, style: TextStyle(color: Colors.black)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  } else {
    return AppBar(
      centerTitle: true,
      backgroundColor: color.withOpacity(0.07),
      elevation: 0,
      title: Text(title, style: TextStyle(color: Colors.black)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

kycScreenAppBar({required String title, required BuildContext context}) {
  if (Platform.isAndroid) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title, style: TextStyle(color: Colors.black)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  } else {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(title, style: TextStyle(color: Colors.black)),
      leading: TextButton(
        child: Text(
          "Close",
          style: TextStyle(color: appPurple),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
