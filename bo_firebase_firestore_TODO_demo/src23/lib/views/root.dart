// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:robbinlaw/services/authorization.dart';
import 'package:robbinlaw/views/home.dart';
import 'package:robbinlaw/views/login.dart';

class Root extends StatelessWidget {
  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    print('Root build: Current User = ${auth.currentUser?.displayName}');
    auth.listen();
    if (auth.currentUser == null) {
      return Login();
    } else {
      return Home();
    }
  }
}