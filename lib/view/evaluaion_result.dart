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

  bool loading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Reporting reporting = new Reporting();
  var data = {};

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    reporting.getLocalEstimateReportData().then((val) => {
      setState(() {
        data = val;
      })
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return mainViews(
        scaffoldKey,
        ctx,
        Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: createAppBar('Result'),
          body: Builder(
              builder: (BuildContext context) {
                return Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: data.length > 0
                          ? Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: scrSize(ctx) * 2),
                              displayValue(ctx, 'Annual DUoS Shares',   convertToCurrency(data['annual_duos_shares'])),
                              SizedBox(height: 15),
                              displayValue(ctx, 'Annual Triad Share',   convertToCurrency(data['annual_triad_share'])),
                              SizedBox(height: 15),
                              displayValue(ctx, 'Annual Energy Savings',  convertToCurrency(data['annual_energy_share'])),
                              SizedBox(height: 15),
                              displayValue(ctx, 'Annual Customer Revenue from National Grid',  convertToCurrency(data['annual_customer_revenue'])),
                              SizedBox(height: 15),
                              displayValue(ctx, 'Total Annual Benefit', convertToCurrency(data['total_annual_benefit'])),
                              SizedBox(height: 15),
                              displayValue(ctx, 'Carbon Emission Reduction', convertToCurrency(data['carbon_emission_reduction']), trailing: 'kg/kWh' ),
                              SizedBox(height: scrSize(ctx) * 2),
                              SizedBox(height: scrSize(ctx) * 2),
                              Container(
                                width: 160,
                                child: FlatButton(
                                    onPressed: () => {
                                      navigateTo(context, path: '/evaluation', cleanUp: false)},
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
                              largeActionButton('Email the Report', () => emailReport(ctx, data['saving_calculation_id']), width: 300.0, icon: Icons.email, isLoading: loading),
                              SizedBox(height: scrSize(ctx) * 10),
                            ] ,
                          )
                      )
                          : display_loading()
                  ),
                );
              }),
        )

      // actions: [
      //   FlatButton(
      //       onPressed: () => {
      //         navigateTo(context, path: '/evaluation', cleanUp: false)},
      //       child: Row(
      //         children: <Widget>[
      //           Icon(Icons.mode_edit, size: 20, color: textAndIconColour),
      //           SizedBox(width: 3.0),
      //           Text('Start Again', style: TextStyle(color:textAndIconColour, fontSize: 15 ))
      //         ],
      //       )
      //   )
      // ],
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

  emailReport(ctx, report_id) async{
    if (loading == true){ return;}
    setState(() { loading = true; });

    var currentEvaluationUserId = await reporting.getCurrentEvaluationUserId();
    reporting.setEvaluationResultId(report_id);

    if(currentEvaluationUserId == null){
      setState(() { loading = false; });
      Navigator.pushNamed(ctx, '/register');
    }else{
      await reporting.sendEstimateReportEmail(currentEvaluationUserId, report_id);

      final snackBar = SnackBar(content: Text('Report sent!'));
      scaffoldKey.currentState.showSnackBar(snackBar);
      await Future.delayed(Duration(seconds: 1));
      navigateTo(ctx, path: '/search_customer');
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
                    subtitle: loading_bar ? display_loading() : Text(subtitle.toString(), style: TextStyle(fontSize: 25, fontFamily: 'OpenSans', fontWeight: FontWeight.bold,  color: textAndIconColour)),
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