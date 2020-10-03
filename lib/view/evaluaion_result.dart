import 'package:flutter/material.dart';
import 'package:pearlstone/utilities/layout_helper.dart';
import 'package:pearlstone/utilities/util.dart';
import 'package:pearlstone/utilities/constants.dart';
import '../utilities/constants.dart';

class EvaluationResult extends StatefulWidget {
  @override
  _EvaluationResultState createState() => _EvaluationResultState();
//  Yellow FFCA0A
//  Grey 505D58
//  https://coolors.co/gradient-palette/505d58-ffca0a?number=7
}

class _EvaluationResultState extends State<EvaluationResult> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  refresh(){ setState(() {}); }

  @override
  Widget build(BuildContext ctx) {
    return mainViews(
        scaffoldKey,
        ctx,
        'Result',
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: scrSize(ctx) * 2),
              displayValue(ctx, 'Annual DUoS Share', 100),
              SizedBox(height: 15),
              displayValue(ctx, 'Annual Triad Share', 90.36),
              SizedBox(height: 15),
              displayValue(ctx, 'Annual Energy Share', 80.36),
              SizedBox(height: 15),
              displayValue(ctx, 'Total Annual Benefit', 15230.36),
              SizedBox(height: 15),
              displayValue(ctx, 'Carbon Emission Reduction', 15230.36, trailing: 'kg/kWh' ),
              SizedBox(height: scrSize(ctx) * 2),
              SizedBox(height: scrSize(ctx) * 2),
              Container(
                width: 150,
                child: FlatButton(
                    onPressed: () => {Navigator.pushNamed(context, '/evaluation')},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.settings_backup_restore, size: 30, color: textAndIconColour),
                        SizedBox(width: 6.0),
                        Text('Start Again', style: TextStyle(color:textAndIconColour, fontSize: 15 ))
                      ],
                    )
                ),
              ),
              largeActionButton('Email the Report', () => {Navigator.pushNamed(context, '/register')}, width: 300.0, icon: Icons.email),
              SizedBox(height: scrSize(ctx) * 10),
            ] ,
          ),
        ),
      actions: [
        FlatButton(
            onPressed: () => {Navigator.pushNamed(context, '/evaluation')},
            child: Row(
              children: <Widget>[
                Icon(Icons.mode_edit, size: 20, color: textAndIconColour),
                SizedBox(width: 3.0),
                Text('Start Again', style: TextStyle(color:textAndIconColour, fontSize: 15 ))
              ],
            )
        )
      ],
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.only(top: 10, bottom: 25),
      //   child: Row (
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: <Widget>[
      //       FlatButton(
      //           onPressed: () => {},
      //           child: Row(
      //             children: <Widget>[
      //               Icon(Icons.poll, size: 30, color: Colors.red),
      //               SizedBox(width: 3.0),
      //               Text('£ Save Less', style: TextStyle(color:textAndIconColour, fontSize: 15 ))
      //             ],
      //           )
      //       ),
      //       FlatButton(
      //           onPressed: () => {},
      //           child: Row(
      //             children: <Widget>[
      //               Icon(Icons.assessment, size: 30, color: Colors.green),
      //               SizedBox(width: 3.0),
      //               Text('££ Save More', style: TextStyle(color:textAndIconColour, fontSize: 15 ))
      //             ],
      //           )
      //       )
      //     ],
      //   ),
      // ), // Removed from phase one
    );
  }
}

Widget displayValue(ctx, title, subtitle, {trailing="£"}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          decoration:  valueBoxDecorationStyle,
        child: Row(
          children: <Widget>[
            Container(
                alignment:  Alignment.center,
                width: scrSize(ctx) * 28,
                child: ListTile(
                  title: Text(title, style: TextStyle(fontSize: 15, color: textAndIconHintColour),),
                  subtitle: Text(subtitle.toString(), style: TextStyle(fontSize: 25, fontFamily: 'OpenSans', fontWeight: FontWeight.bold,  color: textAndIconColour)),
                )
            ),
            Container(
                alignment:  Alignment.center,
                width: scrSize(ctx) * 10,
                child: Text(trailing, style: TextStyle(fontSize: 20, fontFamily: 'OpenSans', fontWeight: FontWeight.bold,  color: textAndIconHintColour))
            ),
          ],
        )
      ),
    ],
  );
}