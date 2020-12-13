import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/controllers/userController.dart';
import 'package:robbinlaw/screens/home.dart';
import 'package:robbinlaw/screens/login.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          print('going to Home');
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
