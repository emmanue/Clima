import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  // solved an issue with the static call on a field
  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    http.Response response = await http.get("api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid");
    if (response.statusCode == 200){
      String data = response.body;
      
      // var longitude = jsonDecode(data)['coord']['lon'];
      // print(longitude);
      //
      // var weatherDescription = jsonDecode(data)['weather'][0]['description']

      var decodedData = jsonDecode(data);

      var tempMain = decodedData['main']['temp'];

      var weatherId = decodedData['weather'][0]['id'];

      var nameOfCity = decodedData['name'];
      
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
