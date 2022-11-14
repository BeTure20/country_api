import 'package:country_api/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme with ChangeNotifier {
  final String key = "theme";
  late SharedPreferences prefs;
  bool _isDarkTheme = false;

  CustomTheme() {
    loadformPrefs();
  }
  bool get getthemedark => _isDarkTheme;
  ThemeMode get currentTheme =>
      _isDarkTheme != false ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    savetoPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  loadformPrefs() async {
    await _initPrefs();
    _isDarkTheme = prefs.getBool(key) ?? false;
    notifyListeners();
  }

  savetoPrefs() async {
    await _initPrefs();
    prefs.setBool(key, true);
  }
}

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: kbackgrounddarkcolor,
    scaffoldBackgroundColor: kprimarylightcolor,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      onPrimaryContainer: Colors.grey[200],
      primary: kbackgrounddarkcolor,
      secondary: Colors.green,
    ),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
    // brightness: Brightness.light,
    canvasColor: kbackgrounddarkcolor,
    appBarTheme: const AppBarTheme(
      backgroundColor: kbackgroundlightcolor,
      elevation: 0.0,
      iconTheme: IconThemeData(color: kbackgrounddarkcolor),
      titleTextStyle: TextStyle(color: kbackgrounddarkcolor),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      color: kbackgrounddarkcolor,
      elevation: 0.0,
      iconTheme: IconThemeData(color: kbackgroundlightcolor),
      titleTextStyle: TextStyle(color: kprimarylightcolor),
    ),
    dialogBackgroundColor: kbackgrounddarkcolor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: kbackgroundlightcolor,
    primaryColorDark: kbackgrounddarkcolor,
    canvasColor: kbackgrounddarkcolor,
    cardColor: kbackgrounddarkcolor,
    dialogTheme: DialogTheme(backgroundColor: kbackgrounddarkcolor),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white54, width: 1)),
    ),
    scaffoldBackgroundColor: kbackgrounddarkcolor,
    colorScheme: const ColorScheme.dark(
      primaryContainer: Color(0xffA9B8D4),
      onPrimaryContainer: kbackgroundcolor,
      primary: kbackgroundlightcolor,
      outline: kbackgroundlightcolor,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
  );
}
