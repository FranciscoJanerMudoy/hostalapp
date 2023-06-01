import 'package:flutter/material.dart';
import 'package:hostalapp/screen/chef_screen.dart';
import 'package:hostalapp/screen/screens.dart';

var customRutes = <String, WidgetBuilder>{
  'Home': (BuildContext context) => const HomeScreen(),
  'Reset': (BuildContext context) => const HomeScreen(),
  'Waiter': (BuildContext context) => const WaiterScreen(),
  'TakeOrder': (BuildContext context) => const TakeOrderScreen(),
  'Product': (BuildContext context) => const ProductScreen(),
  'ConfirmOrder': (BuildContext context) => const ConfirmOrder(),
  "EditOrder": (BuildContext context) => const EditOrderScreen(),
  "InfoOrder": (BuildContext context) => const InfoOrderScreen(),
  'Chef': (BuildContext context) => const ChefScreen(),
  'EditOrderProducts': (BuildContext context) => const EditOrderProductsScreen()
};
