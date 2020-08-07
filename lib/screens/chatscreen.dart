import 'package:flutter/material.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/model/user.dart';
import 'package:my_chat_app/providers/auth_provider.dart';

import 'package:my_chat_app/widgets/chat/messgaes.dart';
import 'package:my_chat_app/widgets/chat/newmessage.dart';
import 'package:my_chat_app/widgets/drawer.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final _auth = AuthProvider();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: kSecondaryColor,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.short_text),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text(
          user.userName == null ? 'Chats' : user.userName,
          style: TextStyle(
            fontSize: 23.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: ChatDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
