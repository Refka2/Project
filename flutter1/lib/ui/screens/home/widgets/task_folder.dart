import 'package:flutter/material.dart';
import 'package:flutter1/ui/screens/addNote/views/add_note.dart';
import 'package:flutter1/ui/screens/taskDetails/widgets/clearButtons.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
class TaskFolder extends StatelessWidget {
  const TaskFolder({
    Key? key,
    required this.title,
    this.tasks_nb,
    required this.press,
    required this.isFolder,
    this.date,
  }) : super(key: key);

  final String? title;
  final int? tasks_nb;
  final VoidCallback press;
  final bool isFolder;
  final String? date;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: size.width *0.05,
        top: size.height * 0.01,
        bottom: size.height * 0.02,
        right:  size.width *0.05,
      ),
      width: isFolder? size.width *0.4: size.width *0.8,
      child: Column(
        children: [
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.only(
                  top: isFolder? size.width *0.18:size.width *0.05,
                left: size.width *0.05,
                bottom: size.width *0.05,
                right: size.width *0.05,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: darkPurple.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button,
                          ),
                          TextSpan(
                              text: isFolder?"${tasks_nb == null ?"All Tasks" : "$tasks_nb items"}":"$date",
                              style: TextStyle(
                                color: lightBlack.withOpacity(0.5),
                              )
                          ),
                        ]

                    ),

                  ),
                  Spacer(),
                  !isFolder?IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                content: Row(
                                  children: [
                                    ClearButton(
                                      backgroundColor: Theme.of(context).backgroundColor,
                                      color: darkPurple,
                                      size: size.height * 0.05,
                                      borderColor: darkPurple,
                                      isIcon: true,
                                      icon: Icons.favorite_border,
                                      press: () {},
                                    ),
                                    SizedBox(
                                      width: size.width * 0.17,
                                    ),
                                    ClearButton(
                                      backgroundColor: Theme.of(context).backgroundColor,
                                      color: darkPurple,
                                      size: size.height * 0.05,
                                      borderColor: darkPurple,
                                      isIcon: true,
                                      icon: Icons.delete,
                                      press: () async {
                                      },
                                    ),
                                    SizedBox(
                                      width: size.width * 0.17,
                                    ),
                                    ClearButton(
                                      backgroundColor: Theme.of(context).backgroundColor,
                                      color: darkPurple,
                                      size: size.height * 0.05,
                                      borderColor: darkPurple,
                                      isIcon: true,
                                      icon: Icons.edit,
                                      press: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return  AddNote();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                        );
                      },
                      icon: Icon(Icons.more_vert),
                  ) : SizedBox(height: 0,)

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}