import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_chat_app/model/chat.dart';
import 'package:my_chat_app/widgets/chat/messagebubble.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<Chat>>(context);
    return messages == null
        ? SpinKitDoubleBounce(
            color: Colors.lightBlueAccent,
            size: 40.0,
          )
        : ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return MessageBubble(message: messages[index]);
            },
            reverse: true,
          );
  }
}
