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
        String presentUid = Get.find<AuthController>().firebaseUser?.uid;
        print('Present User = $presentUid');
        if (presentUid != null) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
