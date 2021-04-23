import 'package:course_work_2/View/MapBikeRoadsView.dart';
import 'package:course_work_2/View/SignUpView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Service/RideModel.dart';
import 'View/RideView.dart';
import 'View/FirstView.dart';
import 'View/MenuView.dart';
import 'Service/AuthService.dart';
import 'View/SignUpView.dart';
import 'Service/ProviderWidget.dart';
import 'View/RidesListView.dart';
import 'View/MapBikeRoadsView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RideModel()),
        //Provider(auth: AuthService()),
      ],
      child: MyProvider(
        auth: AuthService(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Provider Demo',
            home: HomeController(),
            routes: {
              '/rides': (context) => RideScreen(),
              '/firstpage': (context) => FirstView(),
              '/menu': (context) => HomeController(),
              '/signUp': (context) =>
                SignUpView(authFormType: AuthFormType.signUp,),
              '/signIn': (context) => SignUpView(
                authFormType: AuthFormType.signIn,),
              '/ridesList': (context) => RidesList(),
              '/map': (context) => MapBikeRoadsView(),

          //'/addContact': (context) => AddContact(),
        },
      ),)
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = MyProvider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Menu() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}


