import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:reels/screen/homepage/home_page.dart';
import 'package:reels/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Store login status
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.offAll(() => const HomePage());
    } catch (e) {
      Get.snackbar("Registration Failed", e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Store login status
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.offAll(() => const HomePage());
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  RxBool isLoading = false.obs;

  Future<void> handleLogin(String email, String password) async {
    isLoading.value = true;

    await login(email, password);

    isLoading.value = false;
  }

  Future<void> logout() async {
    await _auth.signOut();

    // Remove login data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Get.offAll(() => LoginScreen());
  }
}
