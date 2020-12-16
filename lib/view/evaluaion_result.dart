import 'package:flutter/material.dart';
import 'package:pearlstone/utilities/layout_helper.dart';
import 'package:pearlstone/utilities/reporting.dart';
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

  bool loadingValues = true;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Reporting reporting = new Reporting();

  @override
  Widget build(BuildContext ctx) {
    return mainViews(
        scaffoldKey,
        ctx,
        'Result',
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder(
              future: reporting.getSavingCalculation(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data;
                  return Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: scrSize(ctx) * 2),
                          displayValue(ctx, 'Annual DUoS Shares',   convertToCurrency(data['annual_duos_shares'])),
                          SizedBox(height: 15),
                          displayValue(ctx, 'Annual Triad Share',   convertToCurrency(data['annual_triad_share'])),
                          SizedBox(height: 15),
                          displayValue(ctx, 'Annual Energy Share',  convertToCurrency(data['annual_energy_share'])),
                          SizedBox(height: 15),
                          displayValue(ctx, 'Total Annual Benefit', convertToCurrency(data['total_annual_benefit'])),
                          SizedBox(height: 15),
                          displayValue(ctx, 'Carbon Emission Reduction', data['carbon_emission_reduction'], trailing: 'kg/kWh' ),
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
                          largeActionButton('Email the Report', () => emailReport(ctx, data['saving_calculation_id']), width: 300.0, icon: Icons.email),
                          SizedBox(height: scrSize(ctx) * 10),
                        ] ,
                      )
                  );
                }else{
                  return Container(
                    child: loading(),
                  );
                }
              }
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

  emailReport(ctx, reportId) async{
    var currentEvaluationUserId = await reporting.getCurrentEvaluationUserId();
    reporting.setEvaluationResultId(reportId);

    if(currentEvaluationUserId == null){
      Navigator.pushNamed(ctx, '/register');
    }else{
      reporting.sendEstimateReportEmail(currentEvaluationUserId, reportId);
    }
  }
}

Widget displayValue(ctx, title, subtitle, {trailing="£", loading_bar = false}){
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
                  subtitle: loading_bar ? loading() : Text(subtitle.toString(), style: TextStyle(fontSize: 25, fontFamily: 'OpenSans', fontWeight: FontWeight.bold,  color: textAndIconColour)),
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