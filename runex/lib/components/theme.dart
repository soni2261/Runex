import 'package:flutter/material.dart';
import 'package:runex/constants.dart';
import 'package:runex/services/auth.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  final AuthService _auth = AuthService();

  ThemeData darkTheme = ThemeData(
    primaryColor: Color.fromRGBO(40, 35, 55, 1),
    primaryTextTheme: Typography.material2014().white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    cardTheme: CardTheme(
      color: Color.fromRGBO(90, 70, 110, 1),
    ),
    textTheme: TextTheme(),
    // primaryColorDark: kPrimaryColor,
    scaffoldBackgroundColor: Color.fromRGBO(65, 55, 85, 1),
    //cardColor: Color.fromRGBO(90, 70, 110, 1),
  );

  ThemeData lightTheme = ThemeData(
    primaryColor: kPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    primaryColorDark: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    //cardColor: Color.fromRGBO(90, 70, 110, 1),
  );

  ThemeChanger() {
    _themeData = lightTheme;
  }

  getTheme() => _themeData;
  getDarkTheme() => darkTheme;
  isDark() => _themeData == darkTheme;

  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}
