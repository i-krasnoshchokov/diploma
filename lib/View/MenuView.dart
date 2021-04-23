import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import 'package:course_work_2/Service/ProviderWidget.dart';
import '../Service/AuthService.dart';


class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: _MenuView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 100.0, right: 0.0, bottom:0),
                  child: Center(
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/rides'),
                      child: Text("ride tracking", style: TextStyle(fontSize: 27,
                          fontWeight: FontWeight.w200, color: Colors.black),),
                    ),
                  ),
                )
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom:0),
                  child: Center(
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/ridesList'),
                      child: Text("rides list", style: TextStyle(fontSize: 27,
                          fontWeight: FontWeight.w200, color: Colors.black),),
                    ),
                  ),
                )
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom:0),
                  child: Center(
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/map'),
                      child: Text("bike map", style: TextStyle(fontSize: 27,
                          fontWeight: FontWeight.w200, color: Colors.black),),
                    ),
                  ),
                )
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom:0),
                  child: Center(
                    child: TextButton(
                      child: Text("settings", style: TextStyle(fontSize: 27,
                          fontWeight: FontWeight.w200, color: Colors.black),),
                    ),
                  ),
                )
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom:0),
                  child: Center(
                    child: TextButton(
                      child: Text("log out", style: TextStyle(fontSize: 27,
                          fontWeight: FontWeight.w200, color: Colors.black),
                      ),
                      onPressed: () async {
                        try{
                          AuthService auth = MyProvider.of(context).auth;
                          await auth.signOut();
                          print("Signed out");
                        } catch (e){
                          print (e);
                        }
                      },
                    ),
                  ),
                )
            )
          ],
        )
      ],
    );
  }
}
