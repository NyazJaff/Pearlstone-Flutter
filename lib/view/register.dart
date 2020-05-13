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
              style: TextStyle(color: Colors.white),
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
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
              style: TextStyle(color: Colors.white),
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
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
                  color: Colors.white,
                  fontFamily: 'OpenSans'
              ),
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: hint + ' your Password',
                  hintStyle: kHintTextStyle
              ),
            )
        )
      ],
    );
  }
  Widget _buildRegisterBtn(){
    return  Container (
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.pushNamed(context, '/home'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(30.0)
        ),
        color: Colors.white,
        child: Text (
          'REGISTER',
          style: TextStyle (
            fontWeight:  FontWeight.bold,
            letterSpacing: 3,
            fontFamily: 'OpenSans',
            color: Color(0xFF527DAA),
          ),
        )
      ),
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
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )
            ),
            TextSpan(text: 'Sign in!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildBackground(){
    return Container(
      height:  double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF6093FA),
                Color(0xFF4179E9),
                Color(0xFF225ED9),
                Color(0xFF0344C8),
              ],
              stops: [0.1,0.4,0.7, 0.9]
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              _buildBackground(),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Register With Us',
                        style: TextStyle(
                            color: Colors.white,
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
                      _buildRegisterBtn(),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildSignInBtn(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
