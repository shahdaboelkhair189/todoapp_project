import 'package:flutter/material.dart';
import 'package:todoapp_project/appcolors.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType keyboardType; //
  bool obscureText = false;
  String? Function(String?)? validator;

  CustomTextFormField(
      {required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      required this.validator}); // default bta3k keyboard 3ady w lw 7bet t8yr nady 3leh   });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Appcolors.primaryColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Appcolors.primaryColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Appcolors.redColor)),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Appcolors.redColor),
            ),
            errorMaxLines: 2),
        controller: controller,
        //3ayzeen el user  7yktbo na 7a5do
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator, //
      ),
    );
  }
}
