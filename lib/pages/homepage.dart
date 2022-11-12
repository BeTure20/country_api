import 'package:country_api/pages/homedetails.dart';

import 'package:country_api/constant/constant.dart';
import 'package:country_api/constant/size_config.dart';
import 'package:country_api/inc/api.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late List<Country> countrylist = [];
  bool changelight = false;
  late List<Country> searchData = [];

  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    //_getTheme();
    Api.getcountrylist().then((items) {
      countrylist = items;
      setState(() {});
    });
    // getdata();
  }
//Build a Search System using Flutter
  // _getTheme() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('theme') ?? false;
  // }

  onSearchTextChanged(text) {
    searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not
      setState(() {});
      return;
    }

    countrylist?.forEach((data) {
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
  Widget build(BuildContext context) {
    countrylist = countrylist.toList();
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
                                showLanguageModal(context);
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
                  child: FutureProvider(
                    // lazy: true,
                    create: (context) => Api.getcountrylist(),
                    initialData: countrylist,
                    // initialData: countrylist,
                    child: Consumer(
                      builder: (context, value, child) {
                        // var datalist = countrylist[index];
//                                   var username = countrylist[index].name.common;
//                                   var currentHeader = username.substring(0, 1);
//                                   var header = username.substring(0, 1);
//                                   if (header != currentHeader) {

// }else{
//  return searchData.isNotEmpty
                        // ? mylistdata(searchData)
                        // : mylistdata(countrylist);
// }
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

//  ListView.builder(
//                                 itemCount: countrylist!.length,
//                                 shrinkWrap: true,
//                                 physics: const ScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   var datalist = countrylist[index];
//                                   var username = countrylist[index].name.common;
//                                   var currentHeader = username.substring(0, 1);
//                                   var header = username.substring(0, 1);
//                                   if (header != currentHeader) {
//                                     return Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                             padding: EdgeInsets.only(
//                                                 left: 30, top: 10, bottom: 10),
//                                             child: Text(
//                                               currentHeader,
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             )),
//                                         GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) => Page2(
//                                                         countrylist: datalist,
//                                                         coutryname: datalist
//                                                             .name.common,
//                                                       )),
//                                             );
//                                           },
//                                           child: Hero(
//                                             tag: "$index",
//                                             child: ListTile(
//                                               leading: Image.network(
//                                                 datalist.flags!.png,
//                                                 width: 40,
//                                                 height: 40,
//                                               ),
//                                               title: Text(datalist.name.common),
//                                               subtitle: Text(datalist.capital
//                                                   .replaceAll(
//                                                       RegExp(r"\p{P}",
//                                                           unicode: true),
//                                                       "")),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     );
  ListView mylistdata(searchData) {
    return ListView.builder(
        itemCount: searchData!.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          var datalist = searchData![index];
          var username = searchData[index].name.common;
          var currentHeader = username.substring(0, 1);
          var header = username.substring(0, 1);
          if (index == 0 || index == 0 ? true : (header != currentHeader)) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    color: Colors.black,
                    padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Text(
                      currentHeader,
                      style: TextStyle(fontWeight: FontWeight.bold),
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

  showLanguageModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            // height: 800,
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0, // has the effect of softening the shadow
                    spreadRadius: 0.0, // has the effect of extending the shadow
                  )
                ],
              ),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10),
                        child: const Text(
                          "Languages",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5, right: 5),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.black,
                            icon: const Icon(Icons.close_outlined),
                          )),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xfff8f8f8),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.justify,
                          text: const TextSpan(
                              text:
                                  "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black,
                                  wordSpacing: 1)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
