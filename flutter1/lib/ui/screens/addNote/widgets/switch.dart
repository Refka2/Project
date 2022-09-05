import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class SwitchIOS extends StatefulWidget {
  const SwitchIOS({Key? key}) : super(key: key);

  @override
  State<SwitchIOS> createState() => _SwitchIOSState();
}

class _SwitchIOSState extends State<SwitchIOS> {
  bool value =true;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: CupertinoSwitch(
        activeColor: darkPurple,
        value: value,
        onChanged: (value) => setState(() =>this.value = value),
      ),
    );
  }
}
