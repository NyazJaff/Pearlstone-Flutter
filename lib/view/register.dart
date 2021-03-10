import 'package:flutter/material.dart';
import 'package:pearlstone/class/Input.dart';
import 'package:pearlstone/model/UserModel.dart';
import 'package:pearlstone/sidebar/custom_drawer.dart';
import 'package:pearlstone/utilities/generic_shared_preference.dart';
import 'package:pearlstone/utilities/layout_helper.dart';
import 'package:pearlstone/utilities/login_auth.dart';
import 'package:pearlstone/utilities/reporting.dart';
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
  final Auth auth = new Auth();
  final Reporting reporting = new Reporting();
  final GenericSharedPreference genericSharedPreference  = new GenericSharedPreference();
  bool isLoading = false;
  bool invalidValidation = false;
  UserModel currentUser;

  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact_number = TextEditingController();
  TextEditingController building_name = TextEditingController();
  TextEditingController address_line_1 = TextEditingController();
  TextEditingController address_line_2 = TextEditingController();
  TextEditingController postcode = TextEditingController();

  List<TextEditingController> inputsToValidate;
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    inputsToValidate = [first_name, last_name, email, building_name, address_line_1];
    auth.getCurrentUser().then((user) {
      setState(() {
        currentUser = user;
      });
    });
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
    return mainViews(scaffoldKey, context,  Container(
      height: double.infinity,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: createAppBar('New Customer'),
        body: Builder(
            builder: (BuildContext context) {
              return Container(
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
                        controller: first_name,
                        label: 'First Name *',
                        hint:  'First Name',
                        leadingIcon: Icons.person,
                      ),
                      SizedBox(height: 30.0),
                      Input(
                        controller: last_name,
                        label: 'Family Name *',
                        hint:  'Family Name',
                        leadingIcon: Icons.person,
                      ),
                      SizedBox(height: 30.0),
                      Input(
                        controller: email,
                        label: 'Email Address *',
                        hint:  'Email Address',
                        leadingIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 30.0),
                      Input(
                        controller: contact_number,
                        label: 'Contact Number',
                        hint:  'Contact Number',
                        leadingIcon: Icons.phone_in_talk,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 30.0),
                      Input(
                        controller: building_name,
                        label: 'Building Name *',
                        hint:  'Building Name',
                        leadingIcon: Icons.home,
                      ),
                      SizedBox(height: 30.0),
                      Input(
                        controller: address_line_1,
                        label: 'Address Line 1 *',
                        hint:  'Address Line 1',
                        leadingIcon: Icons.pin_drop,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 30.0),
                      Input(
                        controller: address_line_2,
                        label: 'Address Line 2',
                        hint:  'Address Line 2',
                        leadingIcon: Icons.pin_drop,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 30.0),
                      Input(
                        textInputAction: TextInputAction.done,
                        controller: postcode,
                        label: 'Postcode',
                        hint:  'Postcode',
                        leadingIcon: Icons.pin_drop,
                      ),
                      SizedBox(height: 30.0),
                      _buildInvalidData(),
                      largeActionButton("REGISTER", registerNewUser, isLoading: isLoading ),
                      SizedBox(height: 40.0),
                      // _buildSignInBtn(),
                    ],
                  ),
                ),
              );
            }),
      ),
    ));
  }

  Future<bool> validateData() async{
    invalidValidation = false;
    inputsToValidate.forEach((element) {
      if(element.text == ''){
        setState(() {
          invalidValidation = true;
        });
      }
    });
    return !invalidValidation;
  }

  void registerNewUser() async{

    String message = "User successfully created!";
    setState(() {
      isLoading = true;
    });

    var validData = await validateData();
    if (validData == false) {
      setState(() { isLoading = false; });
      return;
    }

    var role = '0';
    if(currentUser == null){
      role = '2';
    }
    UserModel user = UserModel(
        first_name     : first_name.text,
        last_name      : last_name.text,
        email          : email.text,
        contact_number : contact_number.text,
        building_name  : building_name.text,
        address_line_1 : address_line_1.text,
        address_line_2 : address_line_2.text,
        postcode       : postcode.text,
        role           : role
    );

    var newUserData = await auth.createNewUser(user);
    print (newUserData);
    if('success' != newUserData['status']) {
      showToast(scaffoldKey.currentContext, "Failed to complete the task!");
      setState(() {
        isLoading = false;
      });
      return;
    }

    var evaluationResultId = await reporting.getEvaluationResultId();

    if (evaluationResultId != null) {
      var emailData = await reporting.sendEstimateReportEmail(newUserData['user_id'], evaluationResultId);
      if('success' == emailData['success']) {
        message = "Successfully sent report";
      }
    }

    genericSharedPreference.clearLocalEvaluationData();
    if(currentUser != null){
      navigateTo(context, path:'/search_customer');
    }else{
      navigateTo(context, path:'/login');
    }

  }

  Widget _buildInvalidData(){
    return invalidValidation == true
        ? Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Missing required* field',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    )
        : Container();
  }
}
