import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn){
    themeMode= isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}


class Themes{

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.grey.shade800,
    colorScheme: ColorScheme.dark(),
    backgroundColor: Colors.grey.shade800,
    hintColor: Colors.white
    //iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );
  static final lightTheme =ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.white,
    backgroundColor: lightPurple,
    hintColor: Colors.black,
  );
}