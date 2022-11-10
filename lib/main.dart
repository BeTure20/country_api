import 'package:country_api/inc/themes/config.dart';
import 'package:country_api/inc/themes/custom_theme.dart';
import 'package:country_api/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider<CustomTheme>(
      create: (context) => CustomTheme(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, CustomTheme notifier, child) {
      return MaterialApp(
        title: 'Country Api',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        themeMode: notifier.currentTheme,
        home: const HomePage(),
      );
    });
  }
}
