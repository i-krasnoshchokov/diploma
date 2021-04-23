import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:course_work_2/Service/ProviderWidget.dart';

class RidesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: Text('rides list', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom:0.0),
        child: Container(
          color: Colors.white70,
          child: StreamBuilder(
              stream: getUsersRidesStreamSnapshots(context),
              builder: (context, snapshot) {
                if(!snapshot.hasData) return const Text("Loading...");
                return new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ridesListCard(context, snapshot.data.documents[index]));
              }
          ),
        ),
      ),
    );
  }
}

Stream<QuerySnapshot> getUsersRidesStreamSnapshots(BuildContext context) async* {
  final uid = await MyProvider.of(context).auth.getUserID();
  yield* Firestore.instance.collection('userData').document(uid).collection('rides').snapshots();
}

Widget ridesListCard(BuildContext context, DocumentSnapshot ride) {
  return new Container(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
              child: Row(children: <Widget>[
                Text(ride['datetime'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),),
                Spacer(),
              ]),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Text('Covered distance: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                  Text(ride['distance'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                  Text(' km', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Text('Average speed: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                  Text(ride['averageSpeed'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                  Text(' km/h', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Text('Riding time: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                  Text(ride['time'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}





