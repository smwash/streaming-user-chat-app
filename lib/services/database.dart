import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat_app/model/chat.dart';
import 'package:my_chat_app/model/user.dart';

class Database {
  final _db = Firestore.instance;

  //add user to firestore.
  Future<void> addUser(User user) async {
    return await _db
        .collection('users')
        .document(user.userId)
        .setData(user.toMap());
  }

//get user data:
  Stream<User> getUserData(String userId) {
    return _db
        .collection('users')
        .document(userId)
        .snapshots()
        .map((snapshot) => User.fromFirestore(snapshot.data));
  }

  //getuser emai and username

  //add user messages to firestore:
  Future<void> addMessage(Chat chat) async {
    return await _db.collection('chats').add(chat.toMap());
  }

  // //get user chats:
  Stream<List<Chat>> getMessages() {
    return _db
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Chat.fromFirestore(document.data))
            .toList());
  }
}
