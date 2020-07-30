import 'package:flutter/material.dart';

final textAndIconColour =     Color(0xFF545756);
final textAndIconHintColour = Color(0xFF969998);
final logoYellow =            Color(0xFFFFCA0A);

final appBackgroundFirst =    Color(0xFFf7f7f7);
final appBackgroundSecond =   Color(0xFFededed);

final AssetImage logo = new AssetImage("assets/brand/logo.jpg");


final kHintTextStyle = TextStyle(
  color: textAndIconHintColour,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: textAndIconColour,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFf5dc82),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

Widget largeActionButton(btnLabel, onPress){
  return  Container (
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: RaisedButton(
        elevation: 5.0,
        onPressed: onPress,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(30.0)
        ),
        color: logoYellow,
        child: Text (
          btnLabel,
          style: TextStyle (
            fontWeight:  FontWeight.bold,
            letterSpacing: 3,
            fontFamily: 'OpenSans',
            color: Color(0xFFFFFFFF),
          ),
        )
    ),
  );
}

Widget logoDisplay(){
  return Container(
    height: 128.0,
    width: 128.0,
    decoration: BoxDecoration(
        image: DecorationImage(image: logo)),
  );
}

Widget emptyAppBar(){
  return PreferredSize(
      preferredSize: Size.fromHeight(0.0), // here the desired height
      child: AppBar(
        brightness: Brightness.light,
        backgroundColor: logoYellow,
      )
  );
}
//Layout Helpers
Widget buildBackground(){
  return Container(
    height:  double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              appBackgroundFirst,
              appBackgroundFirst,
              appBackgroundFirst,
              appBackgroundSecond
            ],
            stops: [0.1,0.4,0.7, 0.9]
        )
    ),
  );
}