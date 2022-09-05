import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
class ShowDialog extends StatelessWidget {
  const ShowDialog({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
    build(BuildContext context) async{
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:  Text(text ),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, 'OK'),
            child: const Text(
              'OK',
              style: TextStyle(color: purple),
            ),
          ),
        ],
      ),
    ) ;
  }
}
