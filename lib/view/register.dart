import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pearlstone/class/Input.dart';
import 'package:pearlstone/utilities/layout_helper.dart';
import 'package:pearlstone/utilities/util.dart';
import '../utilities/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
//  Yellow FFCA0A
//  Grey 505D58
//  https://coolors.co/gradient-palette/505d58-ffca0a?number=7
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/login'),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'Already have an Account? ',
                style: TextStyle(
                  color: textAndIconColour,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )
            ),
            TextSpan(text: 'Sign in!',
                style: TextStyle(
                  color: textAndIconColour,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return mainViews(scaffoldKey, context, 'New Customer',  Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
        child: Column(
          children: <Widget>[
            Text(
              'Welcome!',
              style: TextStyle(
                  color: textAndIconColour,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Input(
              label: 'First Name',
              hint:  'First Name',
              leadingIcon: Icons.person,
            ),
            SizedBox(height: 30.0),
            Input(
              label: 'Family Name',
              hint:  'Family Name',
              leadingIcon: Icons.person,
            ),
            SizedBox(height: 30.0),
            Input(
              label: 'Email Address',
              hint:  'Email Address',
              leadingIcon: Icons.email,
            ),
            SizedBox(height: 30.0),
            Input(
              label: 'Mobile Number',
              hint:  'Mobile Number',
              leadingIcon: Icons.phone_in_talk,
            ),
            SizedBox(height: 30.0),
            Input(
              label: 'Building Name',
              hint:  'Building Name',
              leadingIcon: Icons.home,
            ),
            SizedBox(height: 30.0),
            Input(
              label: 'Building Address',
              hint:  'Building Address',
              leadingIcon: Icons.pin_drop,
            ),
            SizedBox(height: 30.0),
            largeActionButton("REGISTER", () => navigateTo(context, path:'/search_customer')),
            SizedBox(height: 40.0),
            // _buildSignInBtn(),
          ],
        ),
      ),
    ));
  }
}
