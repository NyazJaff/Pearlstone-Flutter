import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
//  Yellow FFCA0A
//  Grey 505D58
//  https://coolors.co/gradient-palette/505d58-ffca0a?number=7
}

class _RegisterState extends State<Register> {

  Widget _buildFullName(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            'Full Name *',
            style: kLabelStyle
        ),
        SizedBox(height: 10.0),
        Container(
            alignment:  Alignment.centerLeft,
            decoration:  kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: textAndIconColour),
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: textAndIconColour,
                  ),
                  hintText: 'Enter your Full name',
                  hintStyle: kHintTextStyle
              ),
            )
        )
      ],
    );
  }
  Widget _buildEmail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            'Email *',
            style: kLabelStyle
        ),
        SizedBox(height: 10.0),
        Container(
            alignment:  Alignment.centerLeft,
            decoration:  kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: textAndIconColour),
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: textAndIconColour,
                  ),
                  hintText: 'Enter your Email',
                  hintStyle: kHintTextStyle
              ),
            )
        )
      ],
    );
  }
  Widget _buildPassword(label, hint){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            label,
            style: kLabelStyle
        ),
        SizedBox(height: 10.0),
        Container(
            alignment:  Alignment.centerLeft,
            decoration:  kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              obscureText: true,
              style: TextStyle(
                  color: textAndIconColour,
                  fontFamily: 'OpenSans'
              ),
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: textAndIconColour,
                  ),
                  hintText: hint + ' your Password',
                  hintStyle: kHintTextStyle
              ),
            )
        )
      ],
    );
  }

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
    return Scaffold(
      appBar: emptyAppBar(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              buildBackground(),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
                  child: Column(
                    children: <Widget>[
//                      logoDisplay(),
                      Text(
                        'Register With Us',
                        style: TextStyle(
                            color: textAndIconColour,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildFullName(),
                      SizedBox(height: 30.0),
                      _buildEmail(),
                      SizedBox(height: 30.0),
                      _buildPassword('Password *', "Enter"),
                      SizedBox(height: 30.0),
                      _buildPassword('Confirm password *', "Confirm"),
                      SizedBox(height: 30.0),
                      largeActionButton("REGISTER", () => Navigator.pushNamed(context, '/home') ),
                      SizedBox(height: 40.0),
                      _buildSignInBtn(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
