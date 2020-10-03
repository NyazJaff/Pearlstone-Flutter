import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pearlstone/utilities/layout_helper.dart';
import 'package:pearlstone/utilities/login_auth.dart';
import 'package:pearlstone/utilities/util.dart';
import '../utilities/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
//  Yellow FFCA0A
//  Grey 505D58
//  https://coolors.co/gradient-palette/505d58-ffca0a?number=7
}

class _LoginState extends State<Login> {

  final Auth auth = new Auth();
  final Color logoRound = Color(0xFFEEEEEE);

  Widget _buildEmail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            'Email',
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
  Widget _buildPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            'Password',
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
                  hintText: 'Enter your Password',
                  hintStyle: kHintTextStyle
              ),
            )
        )
      ],
    );
  }
  Widget _buildForgotPasswordBtn(){
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }
  Widget _buildLoginBtn(){
    return largeActionButton("LOGIN", () {
      navigateTo(context, path : '/search_customer' );
      auth.signIn("test@test.com", "123456").then((value) {
        if (value == 'Success') {
          print('dd');
        }else{
          setState(() {

          });
        }
      });
    });
  }
  Widget _buildSignUpBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/register'),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: textAndIconColour,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )
            ),
            TextSpan(text: 'Sign Up!',
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
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              buildBackground(),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
                  child: Column(
                    children: <Widget>[
                      logoDisplay(),
                      Text(
                        'Sign in',
                        style: TextStyle(
                            color: textAndIconColour,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmail(),
                      SizedBox(height: 30.0),
                      _buildPassword(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      SizedBox(height: 40.0),
                      // _buildSignUpBtn(),
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
