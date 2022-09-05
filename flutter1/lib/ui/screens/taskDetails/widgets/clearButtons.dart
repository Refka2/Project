import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class ClearButton extends StatelessWidget {
  ClearButton({
    Key? key,
    required this.color,
    this.backgroundColor,
    required this.size,
    required this.borderColor,
    this.text,
    this.icon,
    this.isIcon = false,
    required this.press,
  }) : super(key: key);
  final Color color;
  final Color? backgroundColor;
  final double size;
  final Color borderColor;
  final String? text;
  final IconData? icon;
  final bool? isIcon;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor ?? lightPurple,
        ),
        child: isIcon == false
            ? Align(
                alignment: Alignment.center,
                child: Text(
                  text!,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              )
            : Icon(
                icon,
                color: color,
              ),
      ),
    );
  }
}
