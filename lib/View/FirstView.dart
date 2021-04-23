import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class FirstView extends StatelessWidget {
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
                child: _StartPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 180.0, right: 0.0, bottom:0),
                  child: Center(
                    child: Text("simple tracker", style: TextStyle(fontSize: 32,
                        fontWeight: FontWeight.w200, color: Colors.black)),
                  ),
                )
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 100.0, right: 0.0, bottom:0),
                  child: Center(
                    child: TextButton(
                      child: Text("Sign in", style: TextStyle(fontSize: 27,
                          fontWeight: FontWeight.w200, color: Colors.black),),
                      onPressed: () => Navigator.pushNamed(context, '/signIn'),
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
                      child: Text("Register", style: TextStyle(fontSize: 27,
                          fontWeight: FontWeight.w200, color: Colors.black),),
                      onPressed: () => Navigator.pushNamed(context, '/signUp'),
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

