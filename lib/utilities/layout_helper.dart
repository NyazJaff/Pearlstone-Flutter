import 'package:flutter/services.dart';
import 'package:pearlstone/loading/flip_loader.dart';
import 'package:flutter/material.dart';
import 'package:pearlstone/model/UserModel.dart';
import 'package:pearlstone/sidebar/custom_drawer.dart';
import 'package:pearlstone/utilities/util.dart';

import 'constants.dart';
import 'login_auth.dart';

TextStyle txtStyle({paramColour: APP_BAR, double paramSize: 20.0, paramBold: false}){
  return TextStyle(
    fontSize: paramSize,
    color: paramColour,
    fontStyle: FontStyle.normal,
    fontWeight: paramBold ? FontWeight.bold : FontWeight.normal,
  );
}

final kHintTextStyle = TextStyle(
  color: textAndIconHintColour,
  fontFamily: 'OpenSans',
);


TextStyle kLabelStyle({fontSize : 14.0}){
  return TextStyle(
    fontSize: fontSize,
    color: textAndIconColour,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );
}

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

final valueBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final valueHintBoxDecorationStyle = TextStyle(
  color: textAndIconHintColour,
  fontSize: 33,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

Widget largeActionButton(btnLabel, onPress, { width : double.infinity, icon: false, isLoading: false}){
  return  Container (
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: width,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: isLoading ? () => {} : onPress,
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(30.0)
      ),
      color: logoYellow,
      child: isLoading
          ? display_loading(padding: 4.0)
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon != false
              ? Padding(padding: const EdgeInsets.only(right: 6.0),
                        child: Icon(icon, size: 30, color: textAndIconColour),)
              : Container(),
          Text(btnLabel, style: TextStyle (
            fontWeight:  FontWeight.bold,
            letterSpacing: 3,
            fontFamily: 'OpenSans',
            color: Color(0xFFFFFFFF),
          ))
        ],
      ),
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

Widget display_loading({padding = 20.0}){
  return Padding (
    padding: EdgeInsets.all(padding),
    child: ColorLoader4 (
      dotOneColor:  Colors.red,
      dotTwoColor:  Colors.lightGreen,
      dotThreeColor:  Colors.blue,
      duration:  Duration(seconds: 2),
    ),
  );
}

currentUser() async {
  UserModel currentUser;
  final Auth auth = new Auth();
  await auth.getCurrentUser().then((user) {
    currentUser = user;
  });
  return currentUser;
}

Widget createAppBar(title, {actions: const <Widget>[]}){
  return AppBar(
      title: Text(title),
      iconTheme: new IconThemeData(color: APP_BAR),
      actions: actions
    // The icon and color for drawer, by default is white
    // backgroundColor: Colors.transparent,
    // elevation: 0.0,
  );
}

mainViews(scaffoldKey, context, viewBody) {
  return Scaffold(
      body:  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () {
            if(FocusScope.of(context).isFirstFocus) {
              FocusScope.of(context).requestFocus(new FocusNode());
            }
            // FocusScope.of(context).requestFocus(new FocusNode());
            // FocusScope.of(context).unfocus(),
          },
          child:  Stack(children: <Widget>[
            buildBackground(),
            viewBody
          ]),
        ),
      )
  );
}


closeKeyboard(context){
  if(FocusScope.of(context).isFirstFocus) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
