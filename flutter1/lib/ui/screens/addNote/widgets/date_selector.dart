import 'package:flutter/material.dart';
import 'package:flutter1/ui/screens/shared/widgets/text.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:flutter1/ui/ui_utils/ui_globals.dart' as globals;

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key}) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  //DateTime date = DateTime.now();


  selectDate(BuildContext) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: globals.date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: darkPurple,
              onPrimary: Colors.white,
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
    if(selectedDate == null) return;
    setState(() => globals.date = selectedDate);
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () => selectDate(context),
        child: Row(
          children: [
            Column(
              children: [
                const Text(
                  "Day",
                  style: TextStyle(
                    color: darkPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                RoundText(
                  text: "${globals.date.day}",
                ),
              ],
            ),
            SizedBox(width: size.width * 0.03),
            Column(
              children: [
                const Text(
                  "Month",
                  style: TextStyle(
                    color: darkPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                RoundText(
                  text: "${globals.date.month}",
                ),
              ],
            ),
            SizedBox(width: size.width * 0.03),
            Column(
              children: [
                const Text(
                  "Year",
                  style: TextStyle(
                    color: darkPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                RoundText(
                  text: "${globals.date.year}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
