import 'package:bloc/bloc.dart';
import 'package:chatapp/message.dart';
import 'package:chatapp/states/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCubit extends Cubit<ChatState>{
  ChatCubit():super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  void sendMessage({required String message,required String email}){
   try {
      messages.add({
        'message': message,
        'createAt': DateTime.now(),
        'id': email,
      });
    }on Exception catch(e){
     //TODO
   }
  }
  List<Message> messagesList=[];
  void getMessage(){
    messages.orderBy('createAt',descending: true).snapshots().listen((event) {
      messagesList.clear();
      for(var doc in event.docs ){
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}