import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels/screen/homepage/home_page.dart';
import 'package:reels/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Redirect after 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {
      Get.offAll(() => const HomePage()); // Go to Home if logged in
    } else {
      Get.offAll(() => LoginScreen()); // Go to Login if not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFA4768),
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
