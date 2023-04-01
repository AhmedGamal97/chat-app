

import 'package:chatapp/compents/custombutton.dart';
import 'package:chatapp/cubits/auth_cubit.dart';
import 'package:chatapp/cubits/register_cubit.dart';
import 'package:chatapp/states/auth_state.dart';
import 'package:chatapp/states/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../compents/widgets.dart';
import '../constant.dart';
import '../helper/showSnackBar.dart';


class RegisterPage extends StatelessWidget {

   var auth= FirebaseAuth.instance;
  String? email;
  bool isloading=false;
  String? password;
  GlobalKey<FormState> formkey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      listener: (context, state) {
        if(state is RegisterLoading){
          isloading=true;
        }else if(state is  RegisterSuccess){
          Navigator.pushNamed(context,"ChatPage");
        }else if(state is  RegisterFailure){
          showSnakBar(context,state.errMessage);
          isloading=false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall:isloading ,
        child: Scaffold(
          backgroundColor: KPrimaryColor,
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                children: [
                  SizedBox(height: 50,),
                  Image.asset("assets/images/scholar.png",height: 100,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Scholar Chat',style: TextStyle(fontSize: 32,color: Colors.white,fontFamily:"pacifico"),),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Register',style: TextStyle(fontSize: 24,color: Colors.white),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Form(
                    key: formkey,
                      child: Column(
                        children: [
                          // input for email
                          CustomTextFormField(obscureText:false,onChanged: (data){email=data;},hintText: 'Email',),
                          SizedBox(height: 10,),
                          // input for password
                          CustomTextFormField(obscureText:true,onChanged: (data){password=data;},hintText: 'Password',),
                          SizedBox(height: 20,),
                          // register button
                          CustomButtom(onTap: ()async{
                            if(formkey.currentState!.validate()){
                              BlocProvider.of<AuthCubit>(context).registreUser(email: email!, password: password!);
                              Navigator.pushReplacementNamed(context,'ChatPage');
                              }else{}
                            },text: "Register"),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "already have an account?",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              GestureDetector(onTap: (){
                                Navigator.pushReplacementNamed(context, "LoginPage");
                              },
                                child: Text(' Login',style:TextStyle(
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
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user =
        await auth.createUserWithEmailAndPassword(
            email: email!, password: password!);
    print(user.user!.displayName);
  }
}
