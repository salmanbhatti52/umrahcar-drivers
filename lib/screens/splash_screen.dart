import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/screens/login_screen.dart';

import '../widgets/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String backImage = "assets/images/custom-car.png";
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    final sharedPref = await SharedPreferences.getInstance();
    var uid = sharedPref.getString('userId');
    print("uiduid: $uid");
    uid != null
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NavBar()))
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LogInPage()));
  }

  initScreen(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
      backgroundColor: secondaryColor,
        body: Container(
            decoration: BoxDecoration(
              // color: secondaryColor,
              image: DecorationImage(
                image: AssetImage(backImage),
                fit: BoxFit.fill,
                
              ),
            ),
            child: SvgPicture.asset(
              'assets/images/umrah-logo.svg',
             height: double.infinity,
             width: double.infinity,
             fit: BoxFit.scaleDown,
            //   colorBlendMode: BlendMode.darken,
            )),
      ),
    );
  }
}
