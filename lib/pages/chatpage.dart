import 'package:chatapp/constant.dart';
import 'package:chatapp/cubits/chat_cubit.dart';
import 'package:chatapp/message.dart';
import 'package:chatapp/states/states.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../compents/chatbubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();
  final _contoller = ScrollController();
 // List<Message> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email =ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          title: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/scholar.png", height: 60,),
              Text('Scholar chat'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    var messagesList=BlocProvider.of<ChatCubit>(context).messagesList;
                    return ListView.builder(
                      reverse: true,
                      controller: _contoller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                          message: messagesList[index],
                        )
                            : ChatBubbleForFriend(
                            message: messagesList[index]);
                      },
                    ) ;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email);
                  controller.clear();
                  _contoller.animateTo(
                      _contoller.position.maxScrollExtent,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn);
                },
                decoration: InputDecoration(
                  hintText: 'send Message',
                  suffixIcon: Icon(
                      Icons.send
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: KPrimaryColor
                      )
                  ),

                ),
              ),
            ),
          ],
        )
    );
  }

}
