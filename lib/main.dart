import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/model/user.dart';
import 'package:my_chat_app/providers/auth_provider.dart';
import 'package:my_chat_app/screens/chatscreen.dart';
import 'package:my_chat_app/services/database.dart';
import 'package:my_chat_app/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'providers/chat_provider.dart';
import 'screens/authscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Database();
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthProvider().user),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        StreamProvider(create: (context) => database.getMessages()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Mulish',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, usersnapshot) {
            if (usersnapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            if (usersnapshot.hasData) {
              return ChatsScreen();
            }
            return AuthScreen();
          },
        ),
      ),
    );
  }
}
