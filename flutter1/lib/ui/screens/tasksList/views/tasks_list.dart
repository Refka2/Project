import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/task_provider.dart';
import 'package:flutter1/ui/screens/addNote/views/add_note.dart';
import 'package:flutter1/ui/screens/home/widgets/header.dart';
import 'package:flutter1/ui/screens/home/widgets/task_folder.dart';
import 'package:flutter1/ui/screens/shared/widgets/title_task.dart';
import 'package:flutter1/ui/screens/taskDetails/views/task_details.dart';
import 'package:flutter1/core/models/task_model.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key,
    this.folderId,
  }) : super(key: key);

  final String? folderId;
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {


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
    final TaskProvider tasks =
    Provider.of<TaskProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Header(isHome: false, isProfile: false,),
          TitleTask(
              press: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return  AddNote(folderId: widget.folderId);
                    },
                  ),
                );
              },
          ),
          Expanded(
            child: StreamBuilder<Iterable<TaskModel>>(
              stream: tasks.getTasks(widget.folderId),

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
