import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_api/pages/homedetails.dart';

import 'package:country_api/constant/constant.dart';
import 'package:country_api/constant/size_config.dart';
import 'package:country_api/inc/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_api/inc/themes/custom_theme.dart';
import 'package:country_api/model/country.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Country> countrylist = [];
  late List regionlist = [];
  late List languagelist = [];
  late List timezonelist = [];
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  late List<Country> sortaz = [];
  bool changelight = false;
  late List<Country> searchData = [];

  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    getConnectivity();
    super.initState();
    //_getTheme();
    Api.getcountrylist().then((items) {
      countrylist = items;
      for (var element in items) {
        regionlist.add(element.region);
        // regionlist.add({"region": element.region, "status": false});
      }
      for (var element in items) {
        timezonelist.add(
            element.timezones.replaceAll(RegExp(r"\p{P}", unicode: true), ""));
      }
      setState(() {});
    });
    // getdata();
  }

//Build a Search System using Flutter
  // _getTheme() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('theme') ?? false;
  // }
  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == true) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });
  onSearchTextChanged(text) {
    searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not
      setState(() {});
      return;
    }

    countrylist.forEach((data) {
      if (data.name.common
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())) {
        searchData.add(
            data); // If not empty then add search data into search data list
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //no duplicate data in the regoin list
    regionlist = [
      ...{...regionlist}
    ];
    // sort the  data in a-z order

    countrylist = countrylist.toList();
    sortaz = countrylist.reversed.toList();
    countrylist.sort((a, b) => a.name.common.compareTo(b.name.common));
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
            Text(
              "Explore",
              style: GoogleFonts.pacifico(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              ".",
              style: GoogleFonts.pacifico(
                color: Colors.amber,
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            )
          ]),
          elevation: 0,
          actions: [
            Consumer<CustomTheme>(builder: (context, notifier, child) {
              return AnimatedContainer(
                duration: const Duration(seconds: 500),
                child: IconButton(
                  icon: !notifier.getthemedark
                      ? const Icon(Icons.light_mode_outlined)
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
            const SizedBox(
              height: 20,
            ),
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
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: onSearchTextChanged,
                      controller: searchcontroller,
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
                            margin: const EdgeInsets.all(3),
                            height: 47.0,
                            width: 90,
                            child: OutlinedButton(
                              onPressed: () {
                                showLanguageModal(context, languagelist);
                              },
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
                            margin: const EdgeInsets.all(3),
                            height: 47.0,
                            width: 90,
                            child: OutlinedButton(
                              onPressed: () {
                                showFliterModal(context, regionlist);
                              },
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
                  child: FutureProvider(
                    create: (context) => Api.getcountrylist(),
                    initialData: countrylist,
                    // initialData: countrylist,
                    child: Consumer(
                      builder: (context, value, child) {
                        return searchData.isNotEmpty
                            ? mylistdata(searchData)
                            : mylistdata(countrylist);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView mylistdata(listdata) {
    return ListView.builder(
        itemCount: listdata!.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          var datalist = listdata[index];
          var userData = listdata[index];
          var usernames = userData.name.common;
          var userDatas = index == 0 ? listdata[index] : listdata[index - 1];
          var username =
              index == 0 ? userData.name.common : userDatas.name.common;
          var currentHeader = usernames.substring(0, 1);
          var header = username.substring(0, 1);
          if (index == 0 || index == 0 ? true : (header != currentHeader)) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Text(
                      currentHeader,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Page2(
                                countrylist: datalist,
                                coutryname: datalist.name.common,
                              )),
                    );
                  },
                  child: Hero(
                    tag: "$index",
                    child: ListTile(
                      leading: Image.network(
                        datalist.flags!.png,
                        width: 40,
                        height: 40,
                      ),
                      title: Text(datalist.name.common),
                      subtitle: Text(datalist.capital
                          .replaceAll(RegExp(r"\p{P}", unicode: true), "")),
                    ),
                  ),
                )
              ],
            );
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Page2(
                            countrylist: datalist,
                            coutryname: datalist.name.common,
                          )),
                );
              },
              child: Hero(
                tag: "$index",
                child: ListTile(
                  leading: Image.network(
                    datalist.flags!.png,
                    width: 40,
                    height: 40,
                  ),
                  title: Text(datalist.name.common),
                  subtitle: Text(datalist.capital
                      .replaceAll(RegExp(r"\p{P}", unicode: true), "")),
                ),
              ),
            );
          }
        });
  }

  showLanguageModal(context, data) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black26,
              //     blurRadius: 10.0, // has the effect of softening the shadow
              //     spreadRadius: 0.0, // has the effect of extending the shadow
              //   )
              // ],
            ),
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Language",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 24,
                            margin: EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF98A2B3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                            ),
                            child: const Icon(Icons.close_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                var region = data;
                                return ListTile(
                                  title: Text(region[index]),
                                  trailing: Checkbox(
                                    value: region[index],
                                    onChanged: (value) {
                                      region[index] = value;
                                    },
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  showFliterModal(context, data) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Fliter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 24,
                            margin: EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF98A2B3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                            ),
                            child: const Icon(Icons.close_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        title: Text(
                          "Continent",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    var region = data;
                                    return ListTile(
                                      title: Text(region[index]),
                                      trailing: Checkbox(
                                        value: region[index],
                                        onChanged: (value) {
                                          setState(() {
                                            // region[index].status = value;
                                          });
                                        },
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          "Time Zone",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    var region = data;
                                    return ListTile(
                                      title: Text(region[index]),
                                      trailing: Checkbox(
                                        value: true,
                                        onChanged: (value) {
                                          setState(() {
                                            value = value;
                                          });
                                        },
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 48,
                              width: 104,
                              child: OutlinedButton(
                                  onPressed: () {}, child: Text("Reset")),
                            ),
                            Container(
                              height: 48,
                              width: 200,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    backgroundColor:
                                        Color.fromRGBO(255, 108, 0, 0.8),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Show Result",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  showDialogBox() => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "No Connection!!",
            ),
            content: Text("Please Check your Internet Connection"),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, "Cancel");
                    setState(() => isAlertSet = false);
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(() => isAlertSet = true);
                    }
                  },
                  child: Text("Okay"))
            ],
          );
        },
      );
}
