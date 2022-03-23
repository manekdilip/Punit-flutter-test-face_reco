import 'package:face_net_authentication/constants/colors.dart';
import 'package:face_net_authentication/pages/home_screen.dart';
import 'package:face_net_authentication/pages/kyc_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppNavigationState();
  }
}

class _AppNavigationState extends State<AppNavigation> {
  int navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: navBarIndex,
          selectedItemColor: appPurple,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KycScreen()));
            } else {
              setState(() {
                navBarIndex = index;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar_circle_fill),
                label: "Payroll Allocation"),
            BottomNavigationBarItem(
                icon: Icon(Icons.app_registration), label: "KYC"),
          ],
        ),
        body: HomeScreen());
  }
}
