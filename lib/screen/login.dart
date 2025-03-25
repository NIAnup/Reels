import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels/controller/auth/authcontroller.dart';
import 'package:reels/screen/registration.dart';
import 'package:reels/widget/customTextfield.dart';
import 'package:reels/widget/custombutton.dart';
import 'package:reels/widget/sizeboxextention.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Sign In",
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
                          validator: (p0) => p0!.isEmpty ? "Enter Email" : null,
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
                      Center(
                        child: Custombutton(
                          text: "Sign In",
                          onTap: () {
                            authController.handleLogin(
                              emailController.text,
                              passwordController.text,
                            );
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
                              Get.off(RegistrationScreen());
                            },
                            child: Text(
                              "Already have an account? Sign In",
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
          ],
        ),
      ),
    );
  }
}
