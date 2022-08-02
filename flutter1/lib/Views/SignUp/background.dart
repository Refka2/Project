import 'package:flutter/material.dart';
class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      // width: double.infinity,
      // height: size.height,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            "assets/images/main_top.png",
            width: size.width * 0.5,
          ),
        ),
          child,
        ],
      ),
    );
  }
}