import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/core/models/folder_model.dart';
import 'package:flutter1/core/providers/folder_provider.dart';
import 'package:flutter1/ui/screens/home/widgets/header.dart';
import 'package:flutter1/ui/screens/home/widgets/task_folder.dart';
import 'package:flutter1/ui/screens/shared/widgets/field.dart';
import 'package:flutter1/ui/screens/tasksList/views/tasks_list.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:flutter1/ui/screens/shared/widgets/title_task.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  Widget buildFolder(FolderModel folder) => TaskFolder(
        title: folder.folderName,
        tasks_nb: folder.itemsNb,
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TasksList(
                  folderId: folder.folderId,
                );
              },
            ),
          );
        },
        isFolder: true,
      );

  late String title;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final FolderProvider folder = Provider.of<FolderProvider>(context);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Header(
          isHome: true,
          isProfile: false,
        ),
        TitleTask(
          title: "Folders",
          press: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Create New Folder",
                      style: TextStyle(
                        color: darkPurple,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Field(
                          icon: Icons.folder_open,
                          hintText: "Title",
                          obscureText: false,
                          validate: (String? value) {
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              title = value.trim();
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            if(title != "")
                            folder.createFolder(title, 0);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Create",
                            style: TextStyle(
                              color: darkPurple,
                            ),
                          )),
                    ],
                  );
                });
          },
        ),
        Expanded(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TaskFolder(
                  title: "All",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TasksList();
                        },
                      ),
                    );
                  },
                  isFolder: true,
                ),
              ),
              Expanded(
                child: StreamBuilder<Iterable<FolderModel>>(
                  stream: folder.getFolder(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final folders = snapshot.data!;
                      return GridView.count(
                          crossAxisCount: 2,
                          children: folders.map(buildFolder).toList());
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
