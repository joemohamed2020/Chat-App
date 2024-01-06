import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
   CustomTextFormFieldWidget({this.isPassword,this.validate,this.onChanged,required this.label,super.key});
  String label;
  Function(String)? onChanged;
  String? Function(String?)? validate;
  bool? isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword??false,
      validator: validate,
      onChanged: onChanged,
        decoration: InputDecoration(
        label: Text(label),
    labelStyle: const TextStyle(color: Colors.white),
    border: const OutlineInputBorder(),
    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    )
    );
  }
}
