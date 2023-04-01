import 'package:chatapp/bloc/auth_bloc.dart';
import 'package:chatapp/bloc/auth_event.dart';
import 'package:chatapp/compents/custombutton.dart';

import 'package:chatapp/cubits/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../compents/widgets.dart';
import '../constant.dart';
import '../helper/showSnackBar.dart';
import '../states/auth_state.dart';

class LoginPage extends StatelessWidget {

  var auth= FirebaseAuth.instance;
  String? email;
  bool isloading=false;
  String? password;
   GlobalKey<FormState> formkey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (context, state) {
          if(state is LoginLoading){
            isloading=true;
          }else if(state is LoginSuccess){
            BlocProvider.of<ChatCubit>(context).getMessage();
            Navigator.pushNamed(context,"ChatPage",arguments: email);
          }else if(state is LoginFailure){
            showSnakBar(context,state.errMessage);
            isloading=false;
          }
      },
     child:ModalProgressHUD(
        inAsyncCall:isloading ,
        child: Scaffold(
          backgroundColor:KPrimaryColor,
          body:SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                children: [
                  const SizedBox(height: 50,),
                  Image.asset("assets/images/scholar.png",height: 100,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Scholar Chat',style: TextStyle(fontSize: 32,color: Colors.white,fontFamily:"pacifico"),),
                    ],
                  ),
                  const SizedBox(height: 75,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('LOGIN',style: TextStyle(fontSize: 24,color: Colors.white),),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Form(key: formkey,
                      child: Column(
                        children: [
                          // input for email
                          CustomTextFormField(obscureText: false,onChanged: (data){email=data;},hintText: 'Email',),
                          const SizedBox(height: 10,),
                          // input for password
                          CustomTextFormField(obscureText:true,onChanged: (data){password=data;},hintText: 'Password',),
                          const SizedBox(height: 20,),
                          // login button
                          CustomButtom(onTap: ()async{
                            if(formkey.currentState!.validate()){
                              BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email!, password: password!));
                              Navigator.pushReplacementNamed(context,'ChatPage');
                            }else{}
                          },text: "Login"),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "don't have an account?",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              GestureDetector(onTap: (){
                                //Navigator.pushNamed(context, "RegisterPage");
                                Navigator.pushReplacementNamed(context, "RegisterPage");
                              },
                                child: const Text(' Register',style:TextStyle(
                                  color: Color(0xffc7ede6)
                                ) ,),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ) ,
        ),
      ),

    );
  }
  Future<void> loginUser() async {
    UserCredential user =
    await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
    print(user.user!.displayName);
  }

}
