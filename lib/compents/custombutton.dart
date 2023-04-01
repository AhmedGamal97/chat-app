import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
   CustomButtom({this.onTap,required this.text});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap ,
      child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(8)
            ),
            width: double.infinity,
            height: 60,
           child: Center(child: Text(text)),
      ),
    );
  }
}
