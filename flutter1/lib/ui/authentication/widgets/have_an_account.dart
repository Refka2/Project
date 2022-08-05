import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';

class HaveAnAccount extends StatelessWidget {

  const HaveAnAccount({
    Key? key,
    this.login= true,
    required this.onPressed,
  }) : super(key: key);
  final bool login;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account ?": "Already have an Account ?",
          style: const TextStyle(color: purple),
        ),
        SizedBox(width: size.width * 0.04),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            login ? "Sign Up": "Sign In",
            style: const TextStyle(
              color: darkPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ],
    );
  }
}