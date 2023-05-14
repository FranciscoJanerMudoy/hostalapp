import 'package:flutter/material.dart';
import 'package:hostalapp/screen/screens.dart';

var customRutes = <String, WidgetBuilder>{
  'Home': (BuildContext context) => const HomeScreen(),
  'Reset': (BuildContext context) => const HomeScreen(),
  'Waiter': (BuildContext context) => const WaiterScreen(),
  'Take': (BuildContext context) => const TakeOrderScreen(),
};
