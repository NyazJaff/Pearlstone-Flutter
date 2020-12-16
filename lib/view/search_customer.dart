import 'package:flutter/material.dart';
import 'package:pearlstone/class/Input.dart';
import 'package:pearlstone/model/UserModel.dart';
import 'package:pearlstone/utilities/layout_helper.dart';
import 'package:pearlstone/utilities/login_auth.dart';
import 'package:pearlstone/utilities/reporting.dart';
import 'package:pearlstone/utilities/util.dart';
import '../utilities/constants.dart';
import 'package:pearlstone/utilities/constants.dart';

class SearchCustomer extends StatefulWidget {
  @override
  _SearchCustomerState createState() => _SearchCustomerState();
//  Yellow FFCA0A
//  Grey 505D58
//  https://coolors.co/gradient-palette/505d58-ffca0a?number=7
}

class _SearchCustomerState extends State<SearchCustomer> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final Auth auth = new Auth();

  TextEditingController nameSearch = TextEditingController();
  final Reporting reporting = new Reporting();


  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    nameSearch.dispose();
    super.dispose();
  }

  onNameChangeCallback(name){
    setState(() {
      auth.getUsersByName(name);
    });
  }

  currentCustomers(){
   return FittedBox(
     child: Container(
         alignment:  Alignment.center,
         decoration:  valueBoxDecorationStyle,
         width: 300,
       padding: EdgeInsets.only(bottom: 20),
       child: Column(
         children: <Widget>[
           Input(
             onNameChangeCallback: onNameChangeCallback,
             controller:  nameSearch,
             hint:        'Customer name',
             leadingIcon: Icons.person_pin,
           ),
           FutureBuilder(
             future: auth.getUsersByName(nameSearch.text),
             builder: (context, snapshot){
               if (snapshot.connectionState == ConnectionState.done) {
                 return Container(
                   height: 200,
                   child: ListView.separated (
                     itemCount: snapshot.data.length,
                     itemBuilder: (BuildContext context, int index){
                       UserModel user = snapshot.data[index];
                       return Material(
                         type: MaterialType.transparency,
                         child: ListTile(
                             title: Text(user.first_name + " " + (safeString(user.last_name))),
                             subtitle:  Container(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.stretch,
                                 children: <Widget>[
                                   Container(
                                     child: Text("ID: "+user.id.toString()),
                                   ),
                                 ],
                               ),),
                             onTap: () {

                               reporting.setCurrentEvaluationUserId(user.id);
                               navigateTo(context, path: '/evaluation');
                             }
                         ),
                       );
                     }, separatorBuilder: (BuildContext context, int index) {
                     return Container();
                   },),
                 );
               }else{
                 return Container(
                   child: loading(),
                 );
               }
             }
           ),
         ],
       )
     ),
   );
  }

  @override
  Widget build(BuildContext context) {
    return mainViews(
        scaffoldKey,
        context,
        'Search existing Customers',
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                currentCustomers(),
                SizedBox(height: 20),
                _buildSignUpBtn()
              ],
            )

          ],
        )
    );
  }

  Widget _buildSignUpBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/register'),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'New customer? ',
                style: TextStyle(
                  color: textAndIconColour,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )
            ),
            TextSpan(text: 'Register!',
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
}
