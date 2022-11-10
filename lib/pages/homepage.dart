import 'package:country_api/constant/constant.dart';
import 'package:country_api/constant/size_config.dart';
import 'package:country_api/inc/api.dart';
import 'package:country_api/inc/themes/config.dart';
import 'package:country_api/inc/themes/custom_theme.dart';
import 'package:country_api/model/country.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<Country>? countrylist;
  late dynamic countrylist;
  bool changelight = false;
  @override
  void initState() {
    super.initState();
    _getTheme();
    print(Api.getcountrylist());
    // countrylist = Api.getcountrylist();
    //get the data in the api
    // getdata();
  }

  getdata() async {
    print(Api.getcountrylist());
  }

//Build a Search System using Flutter
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
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: kbackgroundcolor,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
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
              height: displayHeight(context) * 0.20,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      color: kbackgroundcolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: const Icon(Icons.search),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(3),
                            height: 50.0,
                            width: 90,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.web),
                                  const Text("EN")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(3),
                            height: 50.0,
                            width: 90,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.filter_alt_outlined),
                                  const Text("Fliter")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  child: ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: FlutterLogo(size: 30.0),
                          title: Text('Two-line ListTile'),
                          subtitle: Text('Here is a second line'),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
