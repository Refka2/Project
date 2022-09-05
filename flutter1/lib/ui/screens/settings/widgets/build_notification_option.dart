import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/ui/screens/addNote/widgets/switch.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:flutter1/core/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class BuildNotificationOption extends StatelessWidget {
  const BuildNotificationOption({
    Key? key,
    required this.title,
    required this.isActive,
  }) : super(key: key);

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
          scale: 1,
          child: CupertinoSwitch(
            activeColor: darkPurple,
            value: themeProvider.isDarkMode,
            onChanged: (value){
              final provider = Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleTheme(value);
            },
          ),
        ),
      ],
    );
  }
}
