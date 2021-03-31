import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'dart:async';

import 'ProviderWidget.dart';
import 'RideModel.dart';


class RideScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: Text('ride', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200, color: Colors.black)),
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
  final db = Firestore.instance;

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
                          Center(child: Text("Covered distance:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),)),
                          Text(ride.testRide.distance.toStringAsPrecision(3),
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),),
                          Text("meters", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                        ],)
                    )
                      )),
                  Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 80.0, right: 0.0, bottom:0),
                      child:Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("Average Speed:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),)),
                              Text(ride.averageSpeedInKmPerHour(ride.testRide.averageSpeed),
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),),
                              Text("km/h", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                            ],)
                      )
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 75.0, right: 0.0, bottom:0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Riding time:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                    Text(ride.transformMilliSeconds(ride.stopwatch.elapsedMilliseconds),
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),),
                  ],
                )
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
                        child: Icon(Icons.play_arrow, size: 50, color: Colors.black54, )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Start ride", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                      ),],
                  ), flex: 1,),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed:() async {
                            final uid = await  MyProvider.of(context).auth.getUserID();
                            ride.isRideOn = false;
                            ride.countDistance();
                            ride.countAverageSpeed();
                            ride.testRide.time = ride.transformMilliSeconds(ride.stopwatch.elapsedMilliseconds);
                            ride.stopwatch.stop();
                            //ride.saveRide();
                            ride.positionStream.cancel();
                            print(ride.testRide.averageSpeed);
                            await db.collection("userData").document(uid).collection("rides").add(ride.toJson());
                          },
                          child: Icon(Icons.stop, size: 50, color: Colors.black54,)
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Stop ride", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                    ),],
                  ), flex: 1,),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed:(){
                            ride.cleanRoute();
                          },
                          child: Icon(Icons.clear, size: 50, color: Colors.black54,)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Clear ride", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
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