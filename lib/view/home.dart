import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/constants.dart';
import 'package:pearlstone/model/RadioModel.dart';
import 'package:pearlstone/class/SelectableCard.dart';

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

  static List<Map<String, dynamic>> turnOffOptions = [
    {"key": "low",    "label": "Low (10%)"},
    {"key": "medium", "label": "Medium (20%)"},
    {"key": "high",   "label": "High (30%)"},
  ];

  List<RadioModel> step0 = [
    RadioModel(false, "New", Icons.directions_car),
    RadioModel(false, "Used", Icons.directions_car),
  ];


  List<Map<String, dynamic>> configSteps = [
    {"description": "What is the average kW's hour for peak hours?",
      "tip"       : "Tip: What average kW's hour is?",
      "optionCreateCall" : createAverageKws()
    },
    {"description": "What is the turn off %?",
      "tip"       : "Tip: What turn off is ?",
      "optionCreateCall" : createOption()
    },
    {"description": "How many events per week? ",
      "tip"       : "Tip: What event is ?",
      "optionCreateCall" : crateEventsPerWeek(5)
    },
    {"description": "Events duration (hours) ",
      "tip"       : "Tip: What event is ?",
      "optionCreateCall" : crateDuration(min: 30, max:60)
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
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SelectableCard(options: step0, step: 0),
                    step['optionCreateCall']
                  ],
                ),
              )
          )
        });
    return createdSteps;
  }

  static createOption() {
//    var is18AndOver = configSteps.firstWhere((user) => user['description'].startsWith('What is the assumed'));
    List<Text> textList = [] ;
    print(turnOffOptions);

    turnOffOptions.asMap().forEach((index, entry)
    {
      textList.add(
          Text(entry['label'])
      );
    });

    return Container(
      child: Row (
        children: textList,
      ),
    );
  }

  static createAverageKws() {
    return Container(child: Text('average kws'));
  }

  static crateEventsPerWeek(deault) {
    return Container(child: Text(deault.toString()));
  }

  static crateDuration({min, max}) {
    return Container(child: Text(min.toString() + max.toString()));
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
