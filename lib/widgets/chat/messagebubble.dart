import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/model/chat.dart';
import 'package:my_chat_app/model/user.dart';
import 'package:my_chat_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final Chat message;

  MessageBubble({this.message});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: user.userName == message.userName
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (user.userName != message.userName) Text(message.userName),
          Text(
            message.textMessage,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(DateFormat.MMMMEEEEd()
              .format(message.timestamp.toDate())
              .toString()),
        ],
      ),
    );
  }
}
