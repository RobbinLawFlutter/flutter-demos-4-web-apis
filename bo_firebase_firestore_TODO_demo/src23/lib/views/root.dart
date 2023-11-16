// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:robbinlaw/services/authorization.dart';
import 'package:robbinlaw/views/home.dart';
import 'package:robbinlaw/views/login.dart';

class Root extends StatelessWidget {
  final Authorization auth = Authorization();
  @override
  Widget build(BuildContext context) {
    print('Root build:');
    auth.listen();
    print('Root build: Current User = ${auth.currentUser?.displayName}');
    if (auth.currentUser == null) {
      return Login();
    } else {
      return Home();
    }
  }
}