import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_chat_app/model/chat.dart';
import 'package:my_chat_app/model/user.dart';

import 'package:my_chat_app/services/database.dart';

import 'auth_provider.dart';

class ChatProvider with ChangeNotifier {
  String _textmessage;
  final _database = Database();
  final _authProvider = AuthProvider();

  final _auth = FirebaseAuth.instance;

  //message getter
  String get message => _textmessage;

  //setter
  changeMessage(String newmessage) {
    _textmessage = newmessage;
    notifyListeners();
  }

  //send message:
  sendNewMessage() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData = _database.getUserData(user.uid);

    var newMessage = Chat(
      chatUserId: user.uid,
      textMessage: message,
      //userName: _authProvider.user.,
      timestamp: Timestamp.now(),
    );
    await _database.addMessage(newMessage);
  }
}
