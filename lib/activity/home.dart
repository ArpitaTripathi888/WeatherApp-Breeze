import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app_at/workingclass/worker.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String username = '';
//Async -Functions start but return after some delayed
//function.delayed -functn starts after some delayed

  void showData() async {
    //await  getData();
    print("$username");
  }

  void timer() {
    Future.delayed(Duration(seconds: 3), () {
      print("Alarm is ringing");
    });
    print("you can do other stuff");
  }

  int counter = 1;
  @override
  //it does not refreshs the whole widget tree ,only changes the chosen widget
  void setState(fn) {
    super.setState(fn);
    print("set state called ");
  }

  @override
  //use it when we are getting any data from api
  void initState() {
    super.initState();
    // timer();
    // getData();
    //  showData();
    print("this is init state");
  }

  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map info = ModalRoute.of(context)!.settings.arguments as Map;
    var city_name = ["Mumbai", "Delhi", "Chennai", "Dhar", "Indore", "London"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    String temp = (info['temp_value']).toString();
    String air = (info['air_speed_value']).toString();
    if (temp == "NA") {
      print("NA");
    } else {
      temp = ((info['temp_value']).toString().substring(0, 4));
      air=(info['air_speed_value']).toString().substring(0, 4);
    }

    String icon = info['icon_value'];
    String getcity = info['city_value'];
    String hum = info['hum_value'];
    String des = info['des_value'];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: NewGradientAppBar(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.blue.shade200,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.yellow.shade400],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.4,
                    0.9,
                  ]),
            ),
            child: Column(
              children: [
                Container(
                  //search container
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") == "") {
                            print("Blank search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading", arguments: {
                              "searchText": searchController.text,
                            });
                          }
                          // Navigator.pushNamed(context, "/loading", arguments: {
                          //     "searchText": searchController.text,
                          //   });
                        },
                        child: Container(
                          child: Icon(Icons.search),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search Here ",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                height: 50,
                                child: Image.network(
                                  "https://openweathermap.org/img/wn/$icon@2x.png",
                                  fit: BoxFit.fitHeight,
                                )),
                            SizedBox(width: 15),
                            Column(
                              children: [
                                Text(
                                  "$des",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "In $getcity",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer, size: 30),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(24, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.day_windy),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "$air",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("km/h"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 0, 24, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Percent"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made By Arpita"),
                      Text("Data Providied By Openweathermap.org"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
