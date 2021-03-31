import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'AuthService.dart';
import 'package:course_work_2/ProviderWidget.dart';

class Ride{
  final int id;
  double distance;
  String time;
  double averageSpeed = 0.0;
  //List<Position> route;

  Ride(this.id, this.distance, this.time);
}

class RideModel extends ChangeNotifier {
  List<Ride> rides = [];
  List<Position> route = [];
  Ride testRide = Ride(1, 0, "");
  bool isRideOn = true;
  StreamSubscription positionStream;
  Stopwatch stopwatch = new Stopwatch();

  void tracking() async {
    Geolocator.requestPermission();
    stopwatch.reset();
    positionStream = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.best, distanceFilter: 3).listen(((position) => route.add(position)));
    print(route.toString());
    stopwatch.start();
    notifyListeners();
  }

  void countDistance(){
    if (route.length < 2) {
      testRide.distance = 0;
    } else {
      for (var i = 0; i < route.length - 1; i++) {
        testRide.distance += Geolocator.distanceBetween(
          route[i].latitude, route[i].longitude,
          route[i+1].latitude, route[i+1].longitude
        );
      }
    }
    notifyListeners();
  }

  void cleanRoute(){
    route.clear();
    testRide.distance = 0;
    testRide.averageSpeed = 0;
    stopwatch.reset();
    notifyListeners();
  }

  String transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String  minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String  secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  void countAverageSpeed(){
    testRide.averageSpeed = testRide.distance / (stopwatch.elapsedMilliseconds / 1000);
    notifyListeners();
  }
  void saveRide() async{
    rides.add(Ride(rides.length + 1, testRide.distance, transformMilliSeconds(stopwatch.elapsedMilliseconds)));
  }

  String averageSpeedInKmPerHour(double speed){
    return ((speed * 36)/10).toStringAsPrecision(3);
  }

  String rideDateTime(){
    DateTime dateTime = DateTime.now();
    print(dateTime.toString());
    return dateTime.toString().substring(0, dateTime.toString().indexOf('.'));
  }

  Map<String, dynamic> toJson() => {
    'distance': testRide.distance.toStringAsPrecision(3),
    'time': testRide.time,
    'averageSpeed': averageSpeedInKmPerHour(testRide.averageSpeed),
    'datetime': rideDateTime(),
  };
}


//
//Future<Position> _determinePosition() async {
//  bool serviceEnabled;
//  LocationPermission permission;
//
//  serviceEnabled = await Geolocator.isLocationServiceEnabled();
//  if (!serviceEnabled) {
//    return Future.error('Location services are disabled.');
//  }
//
//  permission = await Geolocator.checkPermission();
//  if (permission == LocationPermission.deniedForever) {
//    return Future.error(
//        'Location permissions are permantly denied, we cannot request permissions.');
//  }
//
//  if (permission == LocationPermission.denied) {
//    permission = await Geolocator.requestPermission();
//    if (permission != LocationPermission.whileInUse &&
//        permission != LocationPermission.always) {
//      return Future.error(
//          'Location permissions are denied (actual value: $permission).');
//    }
//  }
//
//  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//  return position;
//}