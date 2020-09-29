import 'package:basecode/repositories/FirebaseRepository.dart';
import 'package:basecode/screens/DashboardScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/LoginScreen.dart';
import './routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseRepository firebaseRepository = FirebaseRepository();

  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.teal[700],
      accentColor: Colors.yellow[800],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 18.0),
      ),
    ),
    routes: routes,
    home: FutureBuilder(
        future: firebaseRepository.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return DashboardScreen();
          } else {
            return LoginScreen();
          }
        }),
  ));
}
