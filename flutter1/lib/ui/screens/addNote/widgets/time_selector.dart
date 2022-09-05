import 'package:flutter/material.dart';
import 'package:flutter1/ui/screens/shared/widgets/text.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:flutter1/ui/ui_utils/ui_globals.dart' as globals;
class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {

  selectTime(BuildContext) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: globals.time,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: darkPurple,
              onPrimary: lightPurple,
              onBackground: purple,
              onSurface: lightBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: darkPurple,
              ),
            ),
          ),

          child: child!,

        );
      },
    );
    if(selectedTime == null) return;
    setState(() => globals.time = selectedTime);
  }
  @override
  Widget build(BuildContext context) {
    final hours = globals.time.hour.toString().padLeft(2,'0');
    final minutes = globals.time.minute.toString().padLeft(2,'0');
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () => selectTime(context),
        child: Row(
          children: [
            Column(
              children: [
                const Text(
                  "Hour",
                  style: TextStyle(
                    color: darkPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                RoundText(
                  text: hours,
                ),
              ],
            ),
            SizedBox(width: size.width * 0.03),
            Column(
              children: [
                const Text(
                  "Minute",
                  style: TextStyle(
                    color: darkPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                RoundText(
                  text: minutes,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
