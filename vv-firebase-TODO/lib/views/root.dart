import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/views/home.dart';
import 'package:robbinlaw/views/login.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        print("Root Getx initState:");
      },
      builder: (_) {
        print("Root Getx builder:");
        if (Get.find<AuthController>().firebaseUser?.uid != null) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
