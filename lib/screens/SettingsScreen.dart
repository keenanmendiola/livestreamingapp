import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:basecode/repositories/FirebaseRepository.dart';
import 'package:basecode/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "settings";

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final FirebaseRepository firebaseRepository = FirebaseRepository();
  bool isLogginOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: isLogginOut,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlatButton(
                onPressed: () async {
                  setState(() {
                    isLogginOut = true;
                  });
                  await firebaseRepository.signOut();
                  setState(() {
                    isLogginOut = false;
                  });
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: Text("Sign Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
