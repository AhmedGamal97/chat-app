import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({this.onChanged,this.hintText,this.obscureText=false}) ;
  String? hintText;
  Function(String)? onChanged;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data){
        if(data!.isEmpty){
          return 'field is requird';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        )
      ),
    );
  }
}
