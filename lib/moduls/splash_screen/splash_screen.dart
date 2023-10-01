import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_application/layout/home_layout.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "Splash Screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    });
    return Scaffold(
      body: Image.asset("assets/images/splash_screen.png"),
    );
  }
}
