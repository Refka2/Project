import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class GrayText extends StatelessWidget {

  const GrayText({
    Key? key,
    required this.text,
    this.color = lighterGray,
    this.onPressed,
    this.icon,
  }) : super(key: key);
  final String text;
  final Color color;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 25,

            ),
            SizedBox(width: size.width *0.1,),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 17,
              ),
            ),
          ],
        )
    );
  }
}