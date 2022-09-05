import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class Button extends StatelessWidget {

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = darkPurple,
    this.textColor = Colors.white,
    required this.width ,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color color, textColor;
  final double width ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.width *0.04),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width *0.03),
      width: width,
      height: size.height *0.06,
      child: ClipRRect( //to get out of boarders
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}