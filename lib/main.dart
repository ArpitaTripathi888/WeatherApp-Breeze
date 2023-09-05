import 'package:flutter/material.dart';
import 'package:weather_app_at/activity/home.dart';
import 'package:weather_app_at/activity/loading.dart';
import 'package:weather_app_at/activity/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      routes:{
        "/":(context)=>LoadingPage(),
        "/home":(context)=>HomePage(),
         "/loading":(context) => LoadingPage(),
      },
    );
  }
}
