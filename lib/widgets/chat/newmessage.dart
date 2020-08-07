import 'package:flutter/material.dart';
import 'package:my_chat_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _newMessageText = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _newMessageText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _newMessage = Provider.of<ChatProvider>(context);
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _newMessageText,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onChanged: (value) => _newMessage.changeMessage(value),
          ),
        ),
        IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _newMessage.sendNewMessage();

              _newMessageText.text.trim().isEmpty
                  // ignore: unnecessary_statements
                  ? null
                  : _newMessageText.clear();
              FocusScope.of(context).unfocus();
            }),
      ],
    );
  }
}
