import '../message.dart';
//
// abstract class LoginState{}
// class LoginInitial extends LoginState{}
// class LoginSuccess extends LoginState{}
// class LoginFailure extends LoginState{
//   String errMessage;
//   LoginFailure({required this.errMessage});
// }
// class LoginLoading extends LoginState{}
// /////////////////////
// abstract class RegisterState{}
// class RegisterInitial extends RegisterState{}
// class RegisterSuccess extends RegisterState{}
// class RegisterFailure extends RegisterState{
//   String errMessage;
//   RegisterFailure({required this.errMessage});
// }
// class RegisterLoading extends RegisterState{}
//////////////////
abstract class ChatState{}
class ChatInitial extends ChatState{}
class ChatSuccess extends ChatState{
  List<Message>messages;
  ChatSuccess({required this.messages});
}