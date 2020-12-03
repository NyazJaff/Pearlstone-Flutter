import 'package:flutter/material.dart';
import 'package:pearlstone/utilities/constants.dart';
import 'package:pearlstone/utilities/login_auth.dart';
import 'package:pearlstone/view/evaluaion_result.dart';
import 'package:pearlstone/view/search_customer.dart';
import 'model/UserModel.dart';
import 'view/evaluation.dart';
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
        '/login':             (context) => Login(),
        '/register':          (context) => Register(),
        '/evaluation':        (context) => Evaluation(),
        '/search_customer':   (context) => SearchCustomer(),
        '/evaluation_result': (context) => EvaluationResult(),
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