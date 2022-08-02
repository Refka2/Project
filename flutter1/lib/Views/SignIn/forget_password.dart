import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      height: size.height * 0.2,
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
        )),
       child: const Text("hi"),
    );
  }
}
