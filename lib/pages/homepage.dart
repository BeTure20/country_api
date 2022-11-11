import 'dart:convert';
import 'package:flutter_svg/svg.dart';
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
  List<Country>? countrylist;
  bool changelight = false;
  @override
  void initState() {
    super.initState();
    _getTheme();
    // getdata();
  }

  // getdata() {
  //   Api.getcountrylist().then((value) {
  //     countrylist = value;
  //   });
  //   setState(() {});
  // }

//Build a Search System using Flutter
  _getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('theme') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(children: const [
            Text(
              "Explore",
              textScaleFactor: 1.2,
            ),
            Text(
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
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                  child: FutureBuilder(
                    future: Api.getcountrylist(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                var datalist = snapshot.data[index];
                                // var sortdata = snapshot.data.map((value) {
                                //   value.sort((a, b) {
                                //     return a.name.common
                                //         .toLowerCase()
                                //         .compareTo(b.name.common.toLowerCase());
                                //     //softing on alphabetical order (Ascending order by Name String)
                                //   });
                                // });
                                // print(sortdata);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Page2(
                                                countrylist: datalist,
                                                coutryname:
                                                    datalist.name.common,
                                              )),
                                    );
                                  },
                                  child: Hero(
                                    tag: "$index",
                                    child: ListTile(
                                      leading: Image.network(
                                        datalist.flags.png,
                                        width: 40,
                                        height: 40,
                                      ),
                                      title: Text(datalist.name.common),
                                      subtitle: Text(datalist.capital),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  final String coutryname;
  final dynamic countrylist;
  const Page2({
    super.key,
    required this.coutryname,
    required this.countrylist,
  });

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  PageController controller = PageController();
  int _currentIndex = 0;
  var countrylist;
  @override
  void initState() {
    /// initialized [conroller] after the screen is loaded
    countrylist = widget.countrylist;
    print(countrylist);
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    /// [conroller] remove from the widget tree permanantly after the screen is closed
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.coutryname,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 320,
              height: 200, // total height of the container [Image Box]
              child: Stack(
                children: [
                  PageView(
                    controller: controller,
                    scrollDirection:
                        Axis.horizontal, // scrolling direction of image
                    physics: ScrollPhysics(), // scrolling behaviour
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    children: [
                      SizedBox(
                        height: 380,
                        width: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 5)),
                          child: Image.network(
                            countrylist.flags.png, // List of Offers precentages
                            width: MediaQuery.of(context).size.width,
                            colorBlendMode: BlendMode.softLight,
                            color: Colors.black.withOpacity(0.8),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 380,
                        width: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 5)),
                          child: SvgPicture.network(
                            countrylist
                                .coatOfArms.svg, // List of Offers precentages
                            width: MediaQuery.of(context).size.width,
                            colorBlendMode: BlendMode.softLight,
                            color: Colors.black.withOpacity(0.8),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 380,
                        width: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 5)),
                          child: SvgPicture.network(
                            countrylist
                                .coatOfArms.svg, // List of Offers precentages
                            width: MediaQuery.of(context).size.width,
                            colorBlendMode: BlendMode.softLight,
                            color: Colors.black.withOpacity(0.8),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                  // Positioned(
                  //   bottom: 15, // Position form Bottom
                  //   right: 15, // Position from Right
                  //   child: Container(
                  //     height: 15,
                  //     child: ListView.builder(
                  //       itemCount: 4,
                  //       scrollDirection: Axis.horizontal,
                  //       shrinkWrap: true,
                  //       physics: ScrollPhysics(),
                  //       itemBuilder: (BuildContext context, int i2) {
                  //         return Padding(
                  //           padding: const EdgeInsets.all(4.0),
                  //           child: Container(
                  //             height: 5,
                  //             width: 15,
                  //             decoration: _currentIndex == i2
                  //                 ? BoxDecoration(
                  //                     color: Colors
                  //                         .white, // Selected Slider Indicator Color
                  //                     borderRadius: BorderRadius.circular(15))
                  //                 : BoxDecoration(
                  //                     color: Colors
                  //                         .black, // Unselected Slider Indicator Color
                  //                     shape: BoxShape
                  //                         .circle // shape of Unselected indicator
                  //                     ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ) // end indicator
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            mytextdata(
              text1: '',
              text2: '',
            )
          ],
        ),
      ),
    );
  }
}

class mytextdata extends StatelessWidget {
  final String text1;
  final String text2;
  const mytextdata({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text1,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Text(text2,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16))
          ],
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
