import 'package:chatapp/states/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(AuthInitial());
  Future<void> loginUser({required String email, required String password})async {
    emit(LoginLoading());
    try{
      UserCredential user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        emit(LoginFailure(errMessage: 'user not found'));
      }else if(e.code=='wrong-password'){
        emit(LoginFailure(errMessage: 'wrong password'));
      }
    }
    catch(e){
      emit(LoginFailure(errMessage: 'something went worng'));
    }
  }
  Future<void>registreUser({required String email,required String password})async{
    emit(RegisterLoading());
    try{
      UserCredential user=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    }on FirebaseAuthException catch(e){
      if(e.code=='weak-password'){
        emit(RegisterFailure(errMessage: 'weak-password'));
      }else if(e.code=='email-already-in-use'){
        emit(RegisterFailure(errMessage: 'email-already-in-use'));
      }
    }catch(e){emit(RegisterFailure(errMessage: 'there is an error try again'));}
  }

}