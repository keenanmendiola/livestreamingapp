import 'package:basecode/repositories/FirebaseRepository.dart';
import 'package:basecode/screens/SettingsScreen.dart';
import 'package:basecode/tabs/CallLogsTab.dart';
import 'package:basecode/tabs/ChatListTab.dart';
import 'package:basecode/tabs/ContactScreenTab.dart';
import 'package:basecode/utils/getInitials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "dashboard";

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final FirebaseRepository firebaseRepository = FirebaseRepository();
  User user;
  String initials;

  @override
  void initState() {
    super.initState();
    firebaseRepository.getCurrentUser().then((user) {
      setState(() {
        user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading:
              IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.search, size: 26.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SettingsScreen.routeName);
                },
                child: Icon(Icons.more_vert, size: 26.0),
              ),
            ),
          ],
          title: CircleAvatar(
            child: Text(getInitials(user.displayName) ?? ''),
          ),
          centerTitle: true,
          bottom: renderTabs(),
        ),
        body: TabBarView(children: [
          ChatListTab(user),
          CallLogsTab(),
          ContactScreenTab(),
        ]),
      ),
    );
  }

  TabBar renderTabs() {
    return TabBar(tabs: [
      Tab(
        icon: Icon(Icons.message),
      ),
      Tab(
        icon: Icon(Icons.phone),
      ),
      Tab(
        icon: Icon(Icons.contacts),
      ),
    ]);
  }
}
