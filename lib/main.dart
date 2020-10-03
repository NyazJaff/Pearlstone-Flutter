import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:pearlstone/utilities/constants.dart';
import 'package:pearlstone/view/evaluaion_result.dart';
import 'package:pearlstone/view/search_customer.dart';
import 'view/result-graph.dart';
import 'view/evaluation.dart';
import 'view/login.dart';
import 'view/register.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
        '/result-graph':      (context) => StackedAreaNullsLineChart(createSampleData(),
            // Disable animations for image tests.
            animate: false),
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

List<charts.Series<LinearSales, int>> createSampleData() {
  final myFakeDesktopData = [
    new LinearSales(0, 5),
    new LinearSales(1, 15),
  ];

  final myFakeTabletData = [
    new LinearSales(0, 5),
    new LinearSales(1, 15),
  ];

  final myFakeMobileData = [
    new LinearSales(0, 5),
    new LinearSales(1, 15),
    new LinearSales(2, 25),
    new LinearSales(3, 5),

  ];

  return [
    new charts.Series<LinearSales, int>(
      id: 'Desktop',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: myFakeDesktopData,
    ),
    new charts.Series<LinearSales, int>(
      id: 'Tablet',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: myFakeTabletData,
    ),
    new charts.Series<LinearSales, int>(
      id: 'Mobile',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: myFakeMobileData,
    ),
  ];
}
