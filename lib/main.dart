import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RideModel.dart';
import 'RideScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RideModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Demo',
        initialRoute: '/rides',
        routes: {
          '/rides': (context) => RideScreen(),
          //'/addContact': (context) => AddContact(),
        },
      ),
    );
  }
}