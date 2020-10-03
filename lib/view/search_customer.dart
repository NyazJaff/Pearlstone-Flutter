import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pearlstone/class/Input.dart';
import 'package:pearlstone/utilities/layout_helper.dart';
import 'package:pearlstone/utilities/util.dart';
import '../utilities/constants.dart';
import 'package:pearlstone/model/RadioModel.dart';
import 'package:pearlstone/utilities/constants.dart';
import 'package:pearlstone/class/SelectableCard.dart';
import 'package:pearlstone/class/Answers.dart';

class SearchCustomer extends StatefulWidget {
  @override
  _SearchCustomerState createState() => _SearchCustomerState();
//  Yellow FFCA0A
//  Grey 505D58
//  https://coolors.co/gradient-palette/505d58-ffca0a?number=7
}

class _SearchCustomerState extends State<SearchCustomer> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  refresh(){
    setState(() {
    });
  }

  currentCustomers(){
   List<dynamic> textList = [{"name": "Nyaz Jaff"}, {"name": "Ilyas Jaff"}, {"name": "Shakan Jaff"}] ;
   return FittedBox(
     child: Container(
         alignment:  Alignment.center,
         decoration:  valueBoxDecorationStyle,
         width: 300,
       padding: EdgeInsets.only(bottom: 20),
       child: Column(
         children: <Widget>[
           Input(
             hint: 'Customer name',
             leadingIcon: Icons.person_pin,
           ),
           Container(
             height: 200,
             child: ListView.separated (
               itemCount: textList.length,
               itemBuilder: (BuildContext context, int index){
                 var record = textList[index];
                 return Material(
                   type: MaterialType.transparency,
                   child: ListTile(
                       title: Text(record['name']),
                       subtitle:  Container(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                           children: <Widget>[
                             Container(
                               child: Text("ID: 12321 ".toString()),
                             ),
                           ],
                         ),),
                       onTap: () {
                         navigateTo(context, path: '/evaluation');
                       }
                   ),
                 );
               }, separatorBuilder: (BuildContext context, int index) {
               return Container();
             },),
           )
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
