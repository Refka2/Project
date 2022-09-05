import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter1/ui/ui_utils/ui_globals.dart' as globals;
class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPicker();
}

class _ColorPicker extends State<ColorPicker> {
  Color pickerColor =Colors.red;
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Widget buildColorPicker()=> MaterialColorPicker(
    onColorChange: (Color color){
      changeColor(color);
    },
    selectedColor: Colors.red,
    colors: const [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.lightGreen,
    ],
  );

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Pick a color!',
          style: TextStyle(
            color: darkPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildColorPicker(),
            TextButton(
              child: const Text(
                'SELECT',
                style: TextStyle(
                  color: lightBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed:() => Navigator.of(context).pop(),
            )
          ],
        ),
      )
  );

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
  return GestureDetector(
    onTap:() =>pickColor(context),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: pickerColor,
      ),
      width: size.width *0.08,
      height: size.width * 0.08,

    ),
  );
  }
}