import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';
class Field extends StatelessWidget {
  final String hintText;
  final IconData? icon, suffixIcon;
  final FormFieldValidator<String> validate;
  final TextInputType? keyboardType;
  final  bool? obscureText;
  const Field({
    Key? key,
    required this.hintText,
     this.icon,
     required this.validate,
     this.keyboardType,
     this.obscureText,
     this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.5 ,
        child:TextFormField(
          validator: validate,
          keyboardType: keyboardType??TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText??false,
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

            icon: Icon(
                icon,
                color: purple
            ),
            labelText: hintText,
            filled: true,
            fillColor: lightPurple,
            suffixIcon: Icon(
                suffixIcon,
                color: purple
            ),
            // suffixIcon: GestureDetector(
            //   onTap: (){
            //     press = ! press;
            //     Icon(press ? Icons.visibility_off : Icons.visibility);
            //   },
            // ),


          ),
        ),
    );

  }
}