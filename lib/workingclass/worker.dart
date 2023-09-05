import 'package:http/http.dart';
import 'dart:convert';

class Worker {
  String location = "";
  Worker({required this.location}) {
    location = this.location;
  }

  String temp = "";
  String humidity = "";
  String air_speed = "";
  String description = "";
  String main = "";
  String icon = "";
  // String get locationUrl => location;

  // var url = Uri.https("api.openweathermap.org", "/data/2.5/weather",
  //     {'q': location, 'appid': 'f27f41e95a3114d9b1990b8b7aea50c2'});
  Future<void> getData() async {
    try {
      var url = Uri.https("api.openweathermap.org", "/data/2.5/weather",
          {'q': location, 'appid': 'f27f41e95a3114d9b1990b8b7aea50c2'});
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      //getting description
      List weatherData = data['weather'] ?? [];
      Map weatherMainData = weatherData[0] ?? {};

      String getMain_des = weatherMainData['main'];
      String getDesc = weatherMainData['description'];

      // print(weatherData);
      // print(weatherMainData['main']);

      //getting temp,humidity
      Map tempData = data['main'] ?? {};
      var getTemp = tempData['temp'] - 273.15; //degree C
      var getHumidity = tempData['humidity']; //%

      //getting air-speed
      Map wind = data['wind'] ?? {};
      var getAir_speed = wind["speed"] / 0.27777777777778; //km/h

      //Assigning values
      temp = getTemp.toString();
      humidity = getHumidity.toString();
      air_speed = getAir_speed.toString();
      description = getDesc;
      main = getMain_des;
      icon = weatherMainData["icon"].toString();
    } catch (e) {
      print(e);
      temp = "NA";
      humidity = "NA";
      air_speed = "NA ";
      description = "Can't find data";
      main = "NA";
      icon = "09d";
    }
  }
}

Worker instance = Worker(location: "Mumbai");
