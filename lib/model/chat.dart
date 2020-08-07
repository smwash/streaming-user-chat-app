import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String textMessage;
  final String chatUserId;
  final String userName;
  final Timestamp timestamp;

  Chat({
    this.textMessage,
    this.chatUserId,
    this.userName,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatUserId': chatUserId,
      'userName': userName,
      'timestamp': timestamp,
      'textMessage': textMessage,
    };
  }

  Chat.fromFirestore(Map<String, dynamic> doc)
      : chatUserId = doc['chatUserId'],
        userName = doc['userName'],
        timestamp = doc['timestamp'],
        textMessage = doc['textMessage'];
}
