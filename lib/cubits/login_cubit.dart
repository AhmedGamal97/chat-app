// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../states/states.dart';
//
// class LoginCubit extends Cubit<LoginState>{
//   LoginCubit():super(LoginInitial());
//
//   Future<void> loginUser({required String email, required String password})async {
//     emit(LoginLoading());
//     try{
//       UserCredential user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//       emit(LoginSuccess());
//     }on FirebaseAuthException catch(e){
//       if(e.code=='user-not-found'){
//         emit(LoginFailure(errMessage: 'user not found'));
//       }else if(e.code=='wrong-password'){
//         emit(LoginFailure(errMessage: 'wrong password'));
//       }
//     }
//     catch(e){
//       emit(LoginFailure(errMessage: 'something went worng'));
//     }
//   }
//
//
// }