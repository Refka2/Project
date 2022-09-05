import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/task_provider.dart';
import 'package:flutter1/ui/screens/addNote/widgets/color_picker.dart';
import 'package:flutter1/ui/screens/addNote/widgets/date_selector.dart';
import 'package:flutter1/ui/screens/addNote/widgets/switch.dart';
import 'package:flutter1/ui/screens/addNote/widgets/time_selector.dart';
import 'package:flutter1/ui/screens/shared/widgets/button.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:flutter1/ui/ui_utils/ui_globals.dart' as globals;
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key, this.folderId}) : super(key: key);
  final String? folderId;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title, description;
  bool alarm = true;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  late DateTime date = globals.date;
  String time =
      "${globals.time.hour.toString().padLeft(2, '0')} : ${globals.time.minute.toString().padLeft(2, '0')}";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TaskProvider tasks = Provider.of<TaskProvider>(context);
    return Scaffold(
      body: Container(
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
              padding: EdgeInsets.only(
                  top: size.height * 0.04,
                  left: size.width * 0.06,
                  right: size.width * 0.06),
              width: size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
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
                      Text(
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
                  Align(
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
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.white)),
                    onChanged: (value) {
                      setState(() {
                        title = value.trim();
                      });
                    },
                  )
                ],
              ),
            ),

            //bottom screen

            SizedBox(height: size.height * 0.05),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: size.height * 0.07,
                        left: size.width * 0.04,
                        right: size.width * 0.04),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        )),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SelectDate(),
                            SizedBox(width: size.width * 0.09),
                            SelectTime(),
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
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            hintText: "Write down a note",
                            hintStyle: const TextStyle(color: lighterGray),
                            filled: true,
                            fillColor: Theme.of(context).backgroundColor,
                          ),
                          onChanged: (value) {
                            setState(() {
                              description = value.trim();
                            });
                          },
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
                            ColorPicker(),
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
                            SwitchIOS(),
                          ],
                        ),
                        SizedBox(height: size.height * 0.05),
                        Button(
                            width: size.width * 0.4,
                            text: "Save",
                            onPressed: () => {
                                  tasks.createTask(userId, title, description,
                                      date, time, alarm, widget.folderId),
                                  globals.date = DateTime.now(),
                              globals.time = TimeOfDay.now(),
                                  Navigator.pop(context),
                                }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
