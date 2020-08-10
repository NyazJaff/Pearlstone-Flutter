import 'package:flutter/material.dart';
import 'package:pearlstone/utilities/constants.dart';

import 'view/home.dart';
import 'view/login.dart';
import 'view/register.dart';

void main() {
  runApp(MyApp());

//  Yellow FFCA0A
//  Grey 505D58
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Route
      initialRoute: '/home',
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
      },
      title: 'Pearlstone',
      theme: ThemeData(
        primaryColor: logoYellow,
        canvasColor: appBackgroundFirst,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
