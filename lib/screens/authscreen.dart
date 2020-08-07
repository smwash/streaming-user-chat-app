import 'package:flutter/material.dart';
import 'package:my_chat_app/widgets/authform.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(padding: EdgeInsets.all(20.0), child: AuthForm()),
        ),
      ),
    );
  }
}
