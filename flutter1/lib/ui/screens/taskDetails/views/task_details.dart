import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/task_provider.dart';
import 'package:flutter1/ui/screens/addNote/views/add_note.dart';
import 'package:flutter1/ui/screens/taskDetails/widgets/clearButtons.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:provider/provider.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({
    Key? key,
    this.taskId,
  }) : super(key: key);
  final String? taskId;
  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  IconData icon = Icons.favorite_border;
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final TaskProvider task = Provider.of<TaskProvider>(context);
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('tasks')
            .doc(widget.taskId)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          } else if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          } else if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data?.data() as Map<String, dynamic>;

            //UserModel data = UserModel.fromFirestore(snapshot.data?.data());
            // Map<String, dynamic> data =
            //     snapshot.data?.data() as Map<String, dynamic>;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: purple,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.maxFinite,
                            height: size.height * 0.4,
                            decoration: BoxDecoration(
                              color: purple,
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.2,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: size.height * 0.04,
                                right: size.height * 0.04,
                                top: size.height * 0.04),
                            width: size.width,
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                )),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data['title'],
                                    style: TextStyle(
                                      color: darkPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_filled,
                                      color: lightGray,
                                    ),
                                    SizedBox(width: size.width * 0.015),
                                    Text(
                                      "${data['date'].toDate().day}  / ${data['date'].toDate().month} / ${data['date'].toDate().year}",
                                      style: TextStyle(
                                        color: lightGray,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.035),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                      color: darkPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.015),
                                Container(
                                  height: size.height * 0.15,
                                  width: size.width * 0.8,
                                  padding: EdgeInsets.all(size.height * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: Text(
                                    data['description'],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: EdgeInsets.all(size.height * 0.01),
                                    width: size.width * 0.23,
                                    height: size.height * 0.05,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: purple,
                                    ),
                                    child: Text(
                                      "Category",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: size.height * 0.035,
                          left: size.height * 0.035,
                          right: size.height * 0.035,
                          child: Row(
                            children: [
                              ClearButton(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                color: darkPurple,
                                size: size.height * 0.07,
                                borderColor: darkPurple,
                                isIcon: true,
                                icon: icon,
                                press: (){
                                  task.addToFavourites(widget.taskId);
                                  setState(() {
                                    icon = Icons.favorite;
                                  });
                                },
                              ),
                              SizedBox(
                                width: size.width * 0.20,
                              ),
                              ClearButton(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                color: darkPurple,
                                size: size.height * 0.07,
                                borderColor: darkPurple,
                                isIcon: true,
                                icon: Icons.delete,
                                press: () {
                                  task.deleteTask(widget.taskId, data['userId'],data['folderId'] );
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                width: size.width * 0.20,
                              ),
                              ClearButton(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                color: darkPurple,
                                size: size.height * 0.07,
                                borderColor: darkPurple,
                                isIcon: true,
                                icon: Icons.edit,
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const AddNote();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )));
          }
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: CircularProgressIndicator(
                color: lightPurple,
              ),
            ),
          );
        });
  }
}
