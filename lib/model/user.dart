import 'package:flutter/foundation.dart';

class User {
  String userName;
  final String email;
  final String userId;

  User({
    @required this.userName,
    @required this.email,
    @required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userId': userId,
      'userName': userName,
    };
  }

  User.fromFirestore(Map<String, dynamic> doc)
      : email = doc['email'],
        userId = doc['userId'],
        userName = doc['userName'];
}
