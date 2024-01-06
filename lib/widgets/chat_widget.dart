import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
   ChatWidget({required this.text,super.key});
  String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 16),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight:Radius.circular(32),bottomRight: Radius.circular(32) )
        ),
        child:  Text(text,style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
