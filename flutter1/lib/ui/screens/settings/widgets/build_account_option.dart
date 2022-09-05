import 'package:flutter/material.dart';
class BuildAccountOption extends StatelessWidget {
  const BuildAccountOption({
    Key? key,
    required this.context,
    required this.title,
    required this.press,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}