import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  String? text;
  bool? isMe;

  MessageWidget({Key? key, required this.text,required this.isMe}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: BubbleSpecialThree(
          sent: true,
          text: text!,
          isSender:isMe!,
          color: isMe!?Colors.blue[900]!:Colors.deepOrange,
          textStyle: const TextStyle(color: Colors.white),
        )
    );
  }
}