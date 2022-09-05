import 'package:flutter/material.dart';

class Background extends StatelessWidget {


  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/main_top.webp",
              width: size.width * 0.5,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
