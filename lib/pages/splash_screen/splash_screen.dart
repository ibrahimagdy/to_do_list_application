import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do_application/pages/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash Screen";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset("assets/images/splash_screen.png"),
    );
  }
}