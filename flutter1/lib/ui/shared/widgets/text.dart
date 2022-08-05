import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';

class RoundText extends StatelessWidget {
  final String text;
  final Color textColor;
  const RoundText({
    Key? key,
    required this.text,
    this.textColor = lighterGray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: lightPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child:  Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
        ),
      ),

    );
  }
}