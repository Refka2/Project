import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    required this.showPassword,
    required this.labelText,
    required this.placeholder,
    required this.isPasswordTextField,
    required this.validate,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final bool showPassword;
  final String labelText;
  final String placeholder;
  final bool isPasswordTextField;
  final FormFieldValidator<String> validate;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.only(bottom: size.width *0.1),
      child: TextFormField(
        validator: validate,
        controller: controller,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: darkPurple),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: lightBlack),
            ),
            contentPadding:  EdgeInsets.only(bottom: size.width *0.02),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: darkPurple,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: lightBlack,
            )
        ),
        onChanged: onChanged,

      ),
    );
  }
}