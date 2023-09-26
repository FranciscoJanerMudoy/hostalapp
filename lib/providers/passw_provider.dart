import 'package:flutter/material.dart';

class PaswwProvider extends ChangeNotifier {
  bool _showpassw = true;

  bool get password {
    return _showpassw;
  }

  actualizarContra() {
    _showpassw = !_showpassw;
    notifyListeners();
  }
}
