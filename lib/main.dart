import 'package:flutter/material.dart';

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
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/register': (context) => Register(),
      },
      title: 'Pearlstone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
