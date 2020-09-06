import 'package:flutter/cupertino.dart';

class GlobalState extends ChangeNotifier {
  bool isAuthenticated = false;

  void updateIsAuthenticated(bool value) {
    isAuthenticated = value;
    notifyListeners();
  }
}
