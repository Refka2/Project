import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/folder_provider.dart';
import 'package:flutter1/ui/screens/home/views/home.dart';
import 'package:flutter1/ui/screens/profile/views/profile.dart';
import 'package:flutter1/ui/screens/profile/widgets/favourites.dart';
import 'package:flutter1/ui/screens/settings/views/settings.dart';
import 'package:flutter1/ui/screens/shared/widgets/field.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:provider/provider.dart';
class NavigationBar1 extends StatefulWidget {
  const NavigationBar1({Key? key}) : super(key: key);

  @override
  State<NavigationBar1> createState() => _NavigationBar1State();
}

class _NavigationBar1State extends State<NavigationBar1> {
  int currentTab=0;
  final List<Widget> screens =[
    Home(),
    Profile(),
    Setting(),
    Favourites(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();
  late String title;
  @override
  Widget build(BuildContext context) {
    final FolderProvider folder = Provider.of<FolderProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageStorage(  //save and restore values of widgets
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkPurple,
        child: Icon(Icons.add),
        onPressed: () {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: size.height *0.008,
        child: Container(
          height: size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: size.width *0.2,
                    onPressed: (){
                      setState(() {
                        currentScreen=Home();
                        currentTab=0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab ==0 ? darkPurple : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab==0 ? darkPurple : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: size.width *0.25,
                    onPressed: (){
                      setState(() {
                        currentScreen=Profile();
                        currentTab=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab ==1 ? darkPurple : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab==1 ? darkPurple : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: size.width *0.3,
                    onPressed: (){
                      setState(() {
                        currentScreen=Setting();
                        currentTab=2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTab ==2 ? darkPurple : Colors.grey,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: currentTab==2 ? darkPurple : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: size.width *0.01,
                    onPressed: (){
                      setState(() {
                        currentScreen=Favourites();
                        currentTab=3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: currentTab ==3 ? darkPurple : Colors.grey,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(
                              color: currentTab==3 ? darkPurple : Colors.grey,
                            fontSize: 13
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
