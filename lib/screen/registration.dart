import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels/controller/auth/authcontroller.dart';
import 'package:reels/screen/login.dart';
import 'package:reels/widget/customTextfield.dart';
import 'package:reels/widget/custombutton.dart';
import 'package:reels/widget/sizeboxextention.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final keyform = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xFFFA4768)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Reels App",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "uber"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: keyform,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: "uber"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 10),
                          child: Customtextfield(
                            hintText: "Email",
                            validator: (p0) =>
                                p0!.isEmpty ? "Enter Email" : null,
                          ),
                        ),
                        20.0.h,
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 20, right: 20, bottom: 0),
                          child: Customtextfield(
                            hintText: "Password",
                            validator: (p0) =>
                                p0!.isEmpty ? "Enter Password" : null,
                          ),
                        ),
                        20.0.h,
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 20, right: 20, bottom: 0),
                          child: Customtextfield(
                            hintText: "Confirm Password",
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Enter Confirm Password";
                              } else if (p0 != passwordController.text) {
                                return "Password Not Match";
                              }
                            },
                          ),
                        ),
                        20.0.h,
                        Center(
                          child: Custombutton(
                            text: "Sign Up",
                            onTap: () {
                              if (keyform.currentState!.validate()) {
                                if (passwordController.text.trim() !=
                                    confirmPasswordController.text.trim()) {
                                  Get.snackbar("Error", "Password Not Match");
                                } else {
                                  authController.register(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                }
                              }
                            },
                            height: 50,
                            width: 300,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Get.off(LoginScreen());
                              },
                              child: Text(
                                "Don't have an account? Sign up",
                                style: TextStyle(
                                    fontFamily: "uber",
                                    color: Colors.black,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        20.0.h,
                        const Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(
                              "---------------- OR -----------------",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "uber"),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              size: 50,
                              Icons.facebook,
                            ),
                            20.0.w,
                            const Icon(
                              size: 50,
                              Icons.mail,
                            ),
                            20.0.w,
                            const Icon(
                              Icons.apple,
                              size: 50,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
