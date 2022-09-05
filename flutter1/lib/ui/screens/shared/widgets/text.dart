import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class RoundText extends StatelessWidget {

  const RoundText({
    Key? key,
    required this.text,
    this.textColor = lighterGray,
  }) : super(key: key);
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
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