import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:flutter1/ui/ui_utils/ui_globals.dart' as globals;

class Field extends StatelessWidget {


  const Field({
    Key? key,
    required this.hintText,
    this.icon,
    required this.validate,
    this.keyboardType,
    required this.obscureText,
    this.onChanged,
  }) : super(key: key);
  final String hintText;
  final IconData? icon;
  final FormFieldValidator<String> validate;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    globals.obscureText = obscureText;
    return Container(
      margin:  EdgeInsets.symmetric(vertical: size.height *0.01),
      padding: EdgeInsets.symmetric(horizontal: size.width *0.03, vertical: size.height *0.005),
      width: size.width * 0.5,
      child: TextFormField(
        onChanged: onChanged,
        validator: validate,
        keyboardType: keyboardType ?? TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(35),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: purple),
            borderRadius: BorderRadius.circular(35),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(35),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(35),
          ),
          icon: Icon(icon, color: purple),
          labelText: hintText,
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          // suffix: GestureDetector(
          //   onTap: () {
          //     globals.obscureText = ! globals.obscureText;
          //   },
          //   child:
          //       Icon(globals.obscureText ? Icons.visibility_off : Icons.visibility),
          // ),
        ),
      ),
    );
  }
}
