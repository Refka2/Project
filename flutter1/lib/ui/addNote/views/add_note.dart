import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/ui/shared/widgets/button.dart';
import 'package:flutter1/ui/shared/widgets/text.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  DateTime date = DateTime.now();
  TimeOfDay  time = TimeOfDay.now();

  selectTime(BuildContext) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: time,
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
    setState(() => time = selectedTime);
  }

  selectDate(BuildContext) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: date,
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
    setState(() => date = selectedDate);
  }
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

  //Switch
  bool value =true;
  Widget _switch()=> Transform.scale(
    scale: 1,
    child: CupertinoSwitch(
      activeColor: darkPurple,
    value: value,
    onChanged: (value) => setState(() =>this.value = value),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    final hours = time.hour.toString().padLeft(2,'0');
    final minutes = time.minute.toString().padLeft(2,'0');
    return Scaffold(
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(

          constraints: BoxConstraints(
            // minWidth: size.width,
            minHeight: size.height,
          ),
          child: IntrinsicHeight(
            child: Container(

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    darkerPurple,
                    purple,
                  ],
                  begin: FractionalOffset(0.0, 0.3),
                  end: Alignment.topRight,
                ),
              ),
              child: Column(
                children: [

                  //upper screen

                  Container(
                    padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                    width: size.width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 25,

                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                            ),

                            SizedBox(width: size.width * 0.13),
                            const Text(
                            "Create New Task",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.04),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              "Title",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        const TextField(
                          style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.white)
                        ),

                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),

                  //bottom screen


                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        )
                      ),
                      child: Column(
                        children:  [
                          Row(
                            children:  [
                              Align(
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
                                            text: "${date.day}",
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
                                            text: "${date.month}",
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
                                            text: "${date.year}",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.09),
                              Align(
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
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          //Description
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Note",
                              style: TextStyle(
                                color: darkPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextField(
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(35),
                              ),

                              hintText: "Write down a note",
                              hintStyle: const TextStyle(color: lighterGray),
                              filled: true,
                              fillColor: lightPurple,
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            children: [
                              const Text(
                                "Color",
                                style: TextStyle(
                                  color: darkPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(width: size.width * 0.05),
                              GestureDetector(
                                onTap:() =>pickColor(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: pickerColor,
                                  ),
                                  width: size.width *0.08,
                                  height: size.width * 0.08,

                                ),
                              ),
                              SizedBox(width: size.width * 0.25),
                              const Text(
                                "Alarm",
                                style: TextStyle(
                                  color: darkPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(width: size.width * 0.05),
                              _switch(),
                            ],
                          ),
                          SizedBox(height: size.height *0.05),
                          Button(
                            width: size.width *0.4,
                            text: "Save",
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
