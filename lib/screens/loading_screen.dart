import 'package:flutter/material.dart';
import '../services/location.dart';
import '../services/networking.dart';


const apiKey = "214b3a7bd758e35441bc3427e4b1a071";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  // solved an issue with the static call on a field
  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = (location.latitude);
    longitude = (location.longitude);

    NetworkHelper networkHelper = NetworkHelper("api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");

    var weatherData = await networkHelper.getData();


  }
  // asynchronous programming


  @override
  Widget build(BuildContext context) {

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
