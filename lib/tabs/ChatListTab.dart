import 'package:basecode/widgets/CustomTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatListTab extends StatefulWidget {
  final User user;

  ChatListTab(this.user);
  @override
  _ChatListTabState createState() => _ChatListTabState();
}

class _ChatListTabState extends State<ChatListTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: 2,
          itemBuilder: (context, int index) {
            return CustomTile(
              leading: CircleAvatar(),
              title: Text("Some Name"),
              subtitle: Text("Some Message here"),
              isMini: false,
              onTap: () {},
            );
          }),
    );
  }
}
