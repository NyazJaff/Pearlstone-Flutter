import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/constants.dart';
import 'package:pearlstone/model/RadioModel.dart';
import 'package:pearlstone/utilities/constants.dart';
import 'package:pearlstone/class/SelectableCard.dart';
import 'package:pearlstone/class/Answers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
//  Yellow FFCA0A
//  Grey 505D58
//  https://coolors.co/gradient-palette/505d58-ffca0a?number=7
}

class _HomeState extends State<Home> {
  StepperType stepperType = StepperType.horizontal;
  int _currentStep = 0;
  bool complete = false;

  static List<RadioModel> turn_off_options = [
    RadioModel(false, "low", "Low (10%)", Icons.low_priority),
    RadioModel(false, "medium", "Medium (20%)", Icons.brightness_medium),
    RadioModel(false, "high", "High (30%)", Icons.high_quality),
  ];

  List<Map<String, dynamic>> configSteps = [
    { "key"              : "average_kws",
      "description"      : "What is the average kW's hour for peak hours?",
      "tip"              : "Tip: What average kW's hour is?",
      "data"             : ''
    },
    { "key"              : "turn_off",
      "description"      : "What is the turn off %?",
      "tip"              : "Tip: What turn off is ?",
      "data"             : ''
    },
    { "key"              : "events_per_week",
      "description"      : "How many events per week? ",
      "tip"              : "Tip: What event is ?",
      "data"             : 5
    },
    { "key"              : "events_duration",
      "description"      : "Events duration (hours) ",
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
                      step['description'] + answer.toString(),
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'OpenSans',
                          fontSize: 20.0,
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

  refresh(){
    setState(() {
    });
  }

  createTurnOffOption() {
    return SelectableCard(options: turn_off_options, step: 1, function: refresh );
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
    return Container(child: Text('average kws'));
  }

  crateEventsPerWeek(deault) {
    return Container(child: Text(deault.toString()));
  }

  crateEventsDuration(data) {
    return SliderTheme(
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
          });
        },
      ),
    );
//  print(data["max"]);
//    return Container(child: Text(data["min"].toString() + data["max"].toString()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Evaluation'),
        leading: new IconButton( icon: new Icon(Icons.clear), tooltip: 'Main', onPressed: () {}),
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
                  complete
                      ? Expanded(
                    child: Center(
                      child: AlertDialog(
                        title: new Text("Profile Created"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              "Tada!",
                            ),
//                    method2()
                          ],
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              setState(() => complete = false);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                      : Expanded(
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: logoYellow,
        child: Icon(Icons.list),
        onPressed: switchStepType,
      ),
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

  next() {
    _currentStep < 3 ? goTo(_currentStep + 1) : setState(() => complete = true);
  }

  cancel() {
    if (_currentStep > 0) {
      goTo(_currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => _currentStep = step);
  }

  isStepActive(step) {
    return _currentStep >= step;
  }
}
