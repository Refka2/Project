import 'package:flutter/material.dart';
import 'package:flutter1/core/models/task_model.dart';
import 'package:flutter1/core/providers/task_provider.dart';
import 'package:flutter1/ui/screens/home/widgets/task_folder.dart';
import 'package:flutter1/ui/screens/shared/widgets/title_task.dart';
import 'package:flutter1/ui/screens/taskDetails/views/task_details.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Widget buildTask (TaskModel tasks) => TaskFolder(
    title: tasks.title,
    date: "${tasks.date?.day}/${tasks.date?.month}/${tasks.date?.year}",
    press: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context){
            return TaskDetails(taskId : tasks.taskId);
          },
        ),
      );
    },
    isFolder: false,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TaskProvider tasks =
    Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkPurple,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20 * 2.5),
            height:  size.height * 0.08,
            child: Stack(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 56, top: 50),
                  height: size.height * 0.08 - 27,
                  decoration: BoxDecoration(
                    color: darkPurple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        height: 54,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 30,
                              color: darkPurple.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child:TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                      color: darkPurple.withOpacity(0.5)),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  suffixIcon: Icon(Icons.search),
                                ),
                              )
                            ))
              ],
            ),
          ),
          TitleTask(
            title: "Favourites",
            isTask: false,
          ),
          SizedBox(height: size.height * 0.06),

          Expanded(
            child: StreamBuilder<Iterable<TaskModel>>(
              stream: tasks.getFavourites(),

              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Text('Something went wrong! ${snapshot.error}');
                }
                else if(snapshot.hasData){
                  final tasks = snapshot.data!;
                  return ListView(
                      children: tasks.map(buildTask).toList()
                  );
                }
                else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
