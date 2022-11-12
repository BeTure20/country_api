import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        Container(
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
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 5)),
                          child: Image.network(
                            countrylist
                                .coatOfArms.png, // List of Offers precentages
                            width: MediaQuery.of(context).size.width,
                            colorBlendMode: BlendMode.softLight,
                            color: Colors.black.withOpacity(0.8),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
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
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 30,
                      child: Container(
                        color: Color.fromARGB(62, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                              2,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: InkWell(
                                      onTap: () {
                                        controller.animateToPage(index,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      child: CircleAvatar(
                                        radius: 3,
                                        // check if a dot is connected to the current page
                                        // if true, give it a different color
                                        backgroundColor: _currentIndex == index
                                            ? Colors.amber
                                            : Colors.grey,
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Mytextdata(
                text1: 'Population',
                text2: countrylist.population,
              ),
              Mytextdata(
                text1: 'Region',
                text2: countrylist.region,
              ),
              Mytextdata(
                text1: 'Capital ',
                text2: countrylist.capital
                    .replaceAll(RegExp(r"\p{P}", unicode: true), ""),
              ),
              Mytextdata(
                text1: 'Motto',
                text2: countrylist.population,
              ),
              SizedBox(
                height: 20,
              ),
              Mytextdata(
                text1: 'Official language',
                text2: "English",
              ),
              Mytextdata(
                text1: 'Ethic group',
                text2: "Europe",
              ),
              Mytextdata(
                text1: 'Religion',
                text2: "Christianity",
              ),
              Mytextdata(
                text1: 'Government',
                text2: "Parliamentary democracy",
              ),
              SizedBox(
                height: 20,
              ),
              Mytextdata(
                text1: 'Independence',
                text2: "8th September, 1278",
              ),
              Mytextdata(
                text1: 'Area',
                text2: countrylist.area,
              ),
              Mytextdata(
                text1: 'Currency',
                text2: "USD",
              ),
              Mytextdata(
                text1: 'GDP',
                text2: countrylist.population,
              ),
              SizedBox(
                height: 20,
              ),
              Mytextdata(
                text1: 'Time zone',
                text2: countrylist.timezones
                    .replaceAll(RegExp(r"\p{P}", unicode: true), ""),
              ),
              Mytextdata(
                text1: 'Date format ',
                text2: "dd/mm/yyyy",
              ),
              Mytextdata(
                text1: 'Dialling code',
                text2: countrylist.dialcode.root,
              ),
              Mytextdata(
                text1: 'Driving side',
                text2: countrylist.car.side,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Mytextdata extends StatelessWidget {
  final String text1;
  final dynamic text2;
  const Mytextdata({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "$text1: ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text("$text2",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ))
            ],
          ),
          SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}
