// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/services/authorization.dart';
import 'package:robbinlaw/views/home.dart';
import 'package:robbinlaw/views/login.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Root build:');
    Authorization auth = Authorization();
    auth.listen();

    print('Present User = ${auth.authInst.currentUser}');
    if (auth.authInst.currentUser == null) {
      return Login();
    } else {
      return Home();
    }
  }
}