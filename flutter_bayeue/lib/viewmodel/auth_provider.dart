import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  bool firstTime = true;

  void getStarted() {
    firstTime = false;
    notifyListeners();
  }
}
