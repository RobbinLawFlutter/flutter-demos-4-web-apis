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
        print("Root build: Getx builder: try");
        try {
          //The ? allows us to call on .uid when the firebaseUser is null, null safety,
          //and therefore the try will not fail if the firebaseUser is null.
          String presentUid = Get.find<AuthController>().firebaseUser?.uid;
          print('Present User = $presentUid');
          if (presentUid != null) {
            return Home();
          } else {
            return Login();
          }
        } catch (e) {
          print('Root build: Getx builder: catch $e');
          return Center(child: Text("fatal error"));
        }
      },
    );
  }
}
