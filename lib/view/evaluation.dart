import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pearlstone/utilities/layout_helper.dart';
import 'package:pearlstone/utilities/reporting.dart';
import 'package:pearlstone/utilities/util.dart';
import '../utilities/constants.dart';
import 'package:pearlstone/model/RadioModel.dart';
import 'package:pearlstone/utilities/constants.dart';
import 'package:pearlstone/class/SelectableCard.dart';

class Evaluation extends StatefulWidget {
  @override
  _EvaluationState createState() => _EvaluationState();
//  Yellow FFCA0A
//  Grey 505D58
//  https://coolors.co/gradient-palette/505d58-ffca0a?number=7
}

class _EvaluationState extends State<Evaluation> {
  StepperType stepperType = StepperType.vertical;
  int _currentStep = 0;
  bool complete = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController averageKwsController = TextEditingController();
  TextEditingController eventsPerWeek = TextEditingController(text: '5');
  Reporting reporting = new Reporting();
  Map<String, dynamic> answer = {'average_kws': 0, 'turn_off': null, 'events_per_week': 5, 'events_duration': 30.0};

  final List<RadioModel> turn_off_options = [
    RadioModel(false, "low", "10%", Icons.low_priority),
    RadioModel(false, "medium", "20%", Icons.brightness_medium),
    RadioModel(false, "high", "30%", Icons.high_quality),
  ];

  List<Map<String, dynamic>> configSteps = [
    { "key"              : "average_kws",
      "description"      : "What is the peak demand (kw)?",
      "tip"              : "Tip: What average kW's hour is?",
      "data"             : ''
    },
    { "key"              : "turn_off",
      "description"      : "Please select the assumed turn down?",
      "tip"              : "Tip: What turn off is ?",
      "data"             : ''
    },
    { "key"              : "events_per_week",
      "description"      : "How many events per week? ",
      "tip"              : "Tip: What event is ?",
      "data"             : 5
    },
    { "key"              : "events_duration",
      "description"      : "Average duration per event?",
      "tip"              : "Tip: What event is ?",
      "data"             : {"min": 30.0, "max": 360.0, "divisions": 11}
    },
  ];

  List<Step> createSteps() {
    List<Step> createdSteps = [];
    configSteps.asMap().forEach((index, step) => {
          createdSteps.add(
              Step(
                title: Text(''),
                subtitle: Text(''),
                isActive: isStepActive(index),
                state: StepState.complete,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      step['description'],
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'OpenSans',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    callCreateOptionMethod(step['key'], step['data'])
                    //step['key'] == 'turn_off' ? createTurnOffOption() : step['optionCreateCall']
                  ],
                ),
              )
          )
        });
    return createdSteps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar (
        title: Text('Evaluation'),
        leading: new IconButton( icon: new Icon(Icons.clear), tooltip: 'Main', onPressed: () {
          navigateTo(context, path: '/search_customer');
        }),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              buildBackground(),
              Column(
                children: <Widget>[
                  Expanded(
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Stepper(
                            type: stepperType,
                            steps: createSteps(),
                            currentStep: _currentStep,
                            onStepContinue: next,
                            onStepTapped: (step) => goTo(step),
                            onStepCancel: cancel,
                            controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                              return Row(
                                children: <Widget>[
                                  Container(
                                    child: null,
                                  ),
                                  Container(
                                    child: null,
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: logoYellow,
      //   child: Icon(Icons.list),
      //   onPressed: switchStepType,
      // ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10, bottom: 25),
        child: Row (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _currentStep > 0
                ? FlatButton(
                onPressed: cancel,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.arrow_back_ios, size: 30, color: textAndIconColour),
                    SizedBox(width: 3.0),
                    Text('Back', style: TextStyle(color:textAndIconColour, fontSize: 15 ))
                  ],
                )
            )
                : FlatButton(
                onPressed: null,
                child: Text('')
            ),
            _currentStep < configSteps.length - 1
                ? FlatButton(
                onPressed: next,
                child: Row(
                  children: <Widget>[
                    Text('Continue', style: TextStyle(color:textAndIconColour, fontSize: 15 )),
                    SizedBox(width: 3.0),
                    Icon(Icons.arrow_forward_ios, size: 30, color: textAndIconColour)
                  ],
                )
            )
                : FlatButton(
                onPressed: next,
                child: Row(
                  children: <Widget>[
                    Text('Evaluate', style: TextStyle(color:textAndIconColour, fontSize: 15 )),
                    SizedBox(width: 3.0),
                    Icon(Icons.bubble_chart, size: 30, color: logoYellow)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  setTurnOffOption(value){
    setState(() {
      answer["turn_off"] = value;
    });
  }

  createTurnOffOption() {
    return new SelectableCard(key: UniqueKey(), options: turn_off_options, step: 1, function: setTurnOffOption );
//    var is18AndOver = configSteps.firstWhere((user) => user['description'].startsWith('What is the assumed'));
//    List<Text> textList = [] ;
//    print(turnOffOptions);
//    turnOffOptions.asMap().forEach((index, entry)
//    {
//      textList.add(
//          Text(entry['label'])
//      );
//    });
//
//    return Container(
//      child: Row (
//        children: textList,
//      ),
//    );
  }

  createAverageKws() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            alignment:  Alignment.center,
            decoration:  valueBoxDecorationStyle,
            height: 100.0,
            width: 200,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: averageKwsController,
                    onChanged: (String value)  {
                      setState(() {
                        answer['average_kws'] = value;
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                        color: textAndIconColour,
                        fontSize: 33, fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                    decoration:  InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15),
                        hintText: '000.0',
                        hintStyle: valueHintBoxDecorationStyle
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Container (
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 30, right: 10),
                  child: Text("kWh", style: TextStyle (
                    fontWeight:  FontWeight.bold,
                    letterSpacing: 3,
                    fontFamily: 'OpenSans',
                    color: textAndIconHintColour,
                  )),
                ),
              ],
            )
        ),
      ],
    );
  }

  crateEventsPerWeek(deault) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            alignment:  Alignment.center,
            decoration:  valueBoxDecorationStyle,
            height: 100.0,
            width: 230,
            child: Row(
              children: <Widget>[
                FlatButton(
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      var newVal = answer['events_per_week'] - 1;
                      if(newVal >= 0)
                        answer['events_per_week'] = newVal;
                    });
                  },
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 33.0),
                  ),
                ),
                Flexible(
                  child: TextField(
                    readOnly: true,
                    enableInteractiveSelection: false,
                    controller: TextEditingController(text: answer['events_per_week'].toString()),
                    style: TextStyle(
                        color: textAndIconColour,
                        fontSize: 33, fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                    decoration:  InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15),
                        hintStyle: valueHintBoxDecorationStyle
                    ),
                  ),
                ),
                FlatButton(
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      var newVal = answer['events_per_week'] + 1 ;
                      if(newVal <= 10)
                        answer['events_per_week'] = newVal;
                    });
                  },
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 33.0),
                  ),
                )
              ],
            )
        ),
      ],
    );
    return Container(child: Text(deault.toString()));
  }

  crateEventsDuration(data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
            alignment:  Alignment.center,
            decoration:  valueBoxDecorationStyle,
            height: 120.0,
            width: scrSize(_scaffoldKey.currentContext) * 35,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(timeConvert(answer['events_duration']).toString(),
                  style: TextStyle (
                  fontWeight:  FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 20,
                  fontFamily: 'OpenSans',
                  color: textAndIconColour,
                )),
                SizedBox(height: 20),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: textAndIconColour,
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 7.0,
                    thumbColor: logoYellow,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),),
                  child: Slider(
                    value: answer['events_duration'], // Current Slider Value
                    min: data["min"],
                    max: data["max"],
                    divisions: data["divisions"],
                    activeColor: logoYellow,
                    onChanged: (double value) {
                      setState(() {
                        answer['events_duration'] = value.toDouble();
                      });},
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('30 Min', style: TextStyle(color: textAndIconHintColour)),
                    Text('6 Hrs', style: TextStyle(color: textAndIconHintColour)),
                  ],
                )
              ],
            )

        )
      ]

    );
  }

  String timeConvert(double time) {
    return (time/60%24).toString() + " Hours";
  }

  callCreateOptionMethod(key, data){
    switch (key) {
      case "average_kws":
        { return createAverageKws();}
        break;
      case "turn_off":
        { return createTurnOffOption();}
        break;
      case "events_per_week":
        { return crateEventsPerWeek(data);}
        break;
      case "events_duration":
        { return crateEventsDuration(data);}
        break;
    }
  }

  switchStepType() {
    setState(() {
      stepperType == StepperType.horizontal
          ? stepperType = StepperType.vertical
          : stepperType = StepperType.horizontal;
//      steps[2].state = StepState.complete;
    });
  }

  next() async {
    _currentStep < 3
        ? goTo(_currentStep + 1)
        : callEvaluationResult();
  }

  callEvaluationResult() async{
    var repoting_data = await reporting.getSavingCalculation(answer);
    await reporting.setLocalEstimateReportData(repoting_data).then((value) async =>{
      navigateTo(_scaffoldKey.currentContext, path:'/evaluation_result', cleanUp: false)
    });
  }

  cancel() {
    if (_currentStep > 0) {
      goTo(_currentStep - 1);
    }
  }

  goTo(int step) {
    closeKeyboard(_scaffoldKey.currentContext);
    setState(() => _currentStep = step);
  }

  isStepActive(step) {
    return _currentStep >= step;
  }
}
