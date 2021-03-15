import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'dart:async';

import 'RideModel.dart';


class RideScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Ride'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: _MyRideStartStop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _MyRideStartStop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ride = context.watch<RideModel>();
    return Column(
        children: [
              Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 80.0, right: 0.0, bottom:0),
                    child:Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text("Covered distance:", style: TextStyle(fontSize: 18),)),
                          Text(ride.testRide.distance.toStringAsPrecision(3),
                            style: TextStyle(fontSize: 24),),
                          Text("meters", style: TextStyle(fontSize: 20),),
                        ],)
                    )
                      )),
                  Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 80.0, right: 0.0, bottom:0),
                      child:Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("Average Speed:", style: TextStyle(fontSize: 18),)),
                              Text(ride.averageSpeedInKmPerHour(ride.testRide.averageSpeed),
                                style: TextStyle(fontSize: 24),),
                              Text("km/h", style: TextStyle(fontSize: 20),),
                            ],)
                      )
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 80.0, right: 0.0, bottom:0),
                  child: Text(ride.transformMilliSeconds(ride.stopwatch.elapsedMilliseconds),
                    style: TextStyle(fontSize: 24),),
              ),
              Expanded(child:Row(
                children: [
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed:(){
                          ride.isRideOn = true;
                          ride.tracking();
                          print(ride.testRide.distance);

                        },
                        child: Icon(CupertinoIcons.play_arrow, size: 50)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Start ride", style: TextStyle(fontSize: 18),),
                      ),],
                  ), flex: 1,),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed:(){
                            ride.isRideOn = false;
                            ride.countDistance();
                            ride.countAverageSpeed();
                            ride.stopwatch.stop();
                            ride.saveRide();
                            ride.positionStream.cancel();
                            print(ride.testRide.averageSpeed);
                          },
                          child: Icon(CupertinoIcons.stop, size: 50,)
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Stop ride", style: TextStyle(fontSize: 18),),
                    ),],
                  ), flex: 1,),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed:(){
                            ride.cleanRoute();
                          },
                          child: Icon(CupertinoIcons.clear, size: 50,)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Clear ride", style: TextStyle(fontSize: 18),),
                      ),],
                  ), flex: 1,)
                ],
              ))

            ]
    );

//    return Column(
//      children: [
//        FloatingActionButton(
//            onPressed:(){
//              ride.isRideOn = true;
//              ride.tracking();
//              print(ride.testRide.distance);
//            },
//            child: Icon(Icons.play_arrow)
//        ),
//        FloatingActionButton(
//          onPressed:(){
//            ride.isRideOn = false;
//            ride.countDistance();
//            ride.positionStream.cancel();
//            print(ride.testRide.distance);
//          },
//          child:Icon(Icons.stop),
//        ),
//        Text(ride.testRide.distance.toString())
//      ],
//    );
  }
}