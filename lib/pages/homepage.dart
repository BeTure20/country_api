import 'package:country_api/constant/constant.dart';
import 'package:country_api/constant/size_config.dart';
import 'package:country_api/inc/themes/config.dart';
import 'package:country_api/inc/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool changelight = false;

  @override
  void initState() {
    super.initState();

    _getTheme();
  }

  _getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('theme') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(children: [
            Text(
              "Explore",
              textScaleFactor: 1.2,
              style: TextStyle(color: Theme.of(context).canvasColor),
            ),
            const Text(
              ".",
              textScaleFactor: 1.2,
            )
          ]),
          elevation: 0,
          actions: [
            Consumer<CustomTheme>(builder: (context, notifier, child) {
              return AnimatedContainer(
                duration: const Duration(seconds: 500),
                child: IconButton(
                  icon: !notifier.getthemedark
                      ? const Icon(Icons.light_mode)
                      : Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kbackgroundcolor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: const Icon(
                              Icons.dark_mode,
                            ),
                          ),
                        ),
                  onPressed: () {
                    notifier.toggleTheme();
                  },
                ),
              );
            })
          ]),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              //

              height: displayHeight(context) * 0.20,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      color: kbackgroundcolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Search Country",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[200],
                              fontSize: 16),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 0.2),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [Icon(Icons.web), Text("EN")],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 0.2),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [Icon(Icons.web), Text("EN")],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
