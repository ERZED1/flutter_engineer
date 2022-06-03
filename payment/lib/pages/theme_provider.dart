import 'package:flutter/Material.dart';

class ThemeProvider with ChangeNotifier {
  bool isDark = false;

  themeChange() {
    if (isDark == false) {
      isDark = true;
    } else {
      isDark = false;
    }
    notifyListeners();
  }
}
