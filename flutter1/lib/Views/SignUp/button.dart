import 'package:flutter/material.dart';
import 'package:flutter1/colors.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color, textColor;
  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = darkPurple,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      width: size.width * 0.8,
      height: size.height *0.08,
      child: ClipRRect( //to get out of boarders
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}