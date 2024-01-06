import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({required this.function,required this.label,super.key});
  String label;
  VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        child:  Center(
          child: Text(label,style: const TextStyle(color:kPrimaryColor,fontSize: 24),
          ),
        ),
      ),
    );
  }
}
