
import 'package:chatapp/message.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({Key? key,required this.message}) : super(key: key);
 final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(right: 32, left: 16,top: 16,bottom: 16),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(32),
            topRight:Radius.circular(32),
            bottomRight:Radius.circular(32),
          ),
          color: KPrimaryColor,
        ),
        child: Text(
            message.message,
            style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({Key? key,required this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(right: 32, left: 16,top: 16,bottom: 16),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(32),
            topRight:Radius.circular(32),
            bottomLeft:Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
