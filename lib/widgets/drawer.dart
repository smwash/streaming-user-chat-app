import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/model/chat.dart';
import 'package:my_chat_app/model/user.dart';
import 'package:my_chat_app/providers/auth_provider.dart';
import 'package:my_chat_app/services/database.dart';
import 'package:provider/provider.dart';

class ChatDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context);
    //final _stream = Provider.of(context);
    var resultVar;
    User _user;
    getUID() {
      final result = _auth.user.map((user) {
        print(user);
        return User(
          userName: user.userName,
          email: user.email,
          userId: user.userId,
        );
      });
      print(result);
    }

    final currentUser = Provider.of<User>(context);
    print(currentUser.userName);

    return Drawer(
      child: Column(
        children: [
          StreamBuilder<User>(
            stream: Database().getUserData(currentUser.userId),
            builder: (context, snapshot) {
              User user = snapshot.data;
              //print(_auth.getCurrentUser());
              //print(_auth.currentUseremail);
              //print('${_user.userName}');
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              return UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(),
                accountName: Text(
                  currentUser.userName,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  user.email,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LogOut'),
            onTap: () => _auth.signOut(),
          ),
        ],
      ),
    );
  }
}
