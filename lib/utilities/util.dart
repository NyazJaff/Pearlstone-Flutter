import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pearlstone/sidebar/custom_drawer.dart';
import 'constants.dart';
import 'layout_helper.dart';

double scrSize(BuildContext context){
  print(MediaQuery.of(context).size.height / 100);
  return (MediaQuery.of(context).size.height / 100);
  // return MediaQuery.of(context).size.height;
}

navigateTo(BuildContext context, {path: ''}){
  FocusScope.of(context).requestFocus(new FocusNode());
  Navigator.pop(context);
  if(path != ''){
    Navigator.pushNamed(context, path);
  }
}

bool isLargeScreen(BuildContext context){
  return scrSize(context) > 530;
}

bool utilIsAndroid(context){
  bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
  return isAndroid;
}

launchURL(url) async {

}

showToast(context, message){
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  ));
}
