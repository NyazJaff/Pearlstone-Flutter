import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pearlstone/utilities/constants.dart';
import 'package:pearlstone/utilities/util.dart';
import 'menu_item.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: DRAWER,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: scrSize(context) * 10,
                        ),
                        Divider(
                          height: isLargeScreen(context) ? 64 : 30,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.person,
                          title: "Customers",
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/search_customer');
                          },
                        ),
                        MenuItem(
                          icon: Icons.person_add,
                          title: "New Customer",
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/evaluation');
                          },
                        ),
                        Divider(
                          height: scrSize(context) * 5,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.settings,
                          title: "Settings",
                          onTap: () async {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                        MenuItem(
                          icon: Icons.exit_to_app,
                          title: "Logout",
                          onTap: () async {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/login');
                          },
                        )
                      ],
                    ),
                  ],
                )
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: Colors.amber,
//                    padding: EdgeInsets.all(0),
                child: ListTile (
                  leading: Icon(Icons.report_problem,color: DRAWER, size: 40.0),
                  title: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: 'Found an issue?'),
                              // TextSpan(text: ' Nyaz Jaff'),
                            ],
                          )),
                  subtitle: Text ("Log it here.."),
                  onTap: (){
                    Navigator.pop(context);
                    launchURL('https://www.linkedin.com/in/nyazjaff/');
                  },
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
