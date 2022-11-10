import 'package:country_api/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme with ChangeNotifier {
  final String key = "theme";
  late SharedPreferences prefs;
  bool _isDarkTheme = false;

  CustomTheme() {
    _isDarkTheme = false;
    loadformPrefs();
  }
  bool get getthemedark => _isDarkTheme;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

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
    primaryColor: kprimarylightcolor,
    scaffoldBackgroundColor: kprimarylightcolor,
    fontFamily: 'Montserrat',
    textTheme: Theme.of(context).textTheme,
    brightness: Brightness.light,
    canvasColor: kbackgrounddarkcolor,
    appBarTheme: const AppBarTheme(
      color: kbackgroundlightcolor,
      elevation: 0.0,
      iconTheme: IconThemeData(color: kbackgrounddarkcolor),
      titleTextStyle: TextStyle(color: kprimarylightcolor, fontSize: 25),
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
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kprimarydarkcolor,
      brightness: Brightness.dark,
      canvasColor: kbackgroundlightcolor,
      scaffoldBackgroundColor: kbackgrounddarkcolor,
      fontFamily: 'Montserrat',
      textTheme: Theme.of(context).textTheme,
      primaryTextTheme: TextTheme(titleLarge: TextStyle(color: Colors.white)));
}
