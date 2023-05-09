import 'package:flutter/material.dart';
import 'package:hostalapp/screen/home_screen.dart';
import 'package:hostalapp/screen/login_screen.dart';

var customRutes = <String, WidgetBuilder>{
  'Home': (BuildContext context) => const HomeScreen(),
  'Reset': (BuildContext context) => const HomeScreen()
};
