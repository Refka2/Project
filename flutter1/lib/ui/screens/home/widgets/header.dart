import 'package:flutter/material.dart';
import 'package:flutter1/ui/screens/shared/widgets/avatar.dart';
import 'package:flutter1/ui/screens/shared/widgets/rich_text.dart';
import 'package:flutter1/ui/screens/taskDetails/widgets/clearButtons.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.isHome,
    required this.isProfile,
    this.username,
    this.email,
    this.imageUrl,
  }) : super(key: key);
  final bool isHome;

  final bool isProfile;
  final String? username;
  final String? email;
  final String? imageUrl;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime date = DateTime.now();
    return Container(
      margin: EdgeInsets.only(bottom: 20 * 2.5),
      height: widget.isProfile ? size.height * 0.52 : size.height * 0.31,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 56, top: 50),
            height: widget.isProfile
                ? size.height * 0.52 - 56
                : size.height * 0.31 - 27,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  darkerPurple,
                  purple,
                ],
                begin: FractionalOffset(0.0, 0.3),
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Column(
              children: [
                !widget.isProfile
                    ? Row(
                        children: [
                          Text(
                            "Hello!",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                          ),
                        ],
                      )
                    : Avatar(
                        username: widget.username,
                        email: widget.email,
                        imageUrl: widget.imageUrl,
                      ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                widget.isHome
                    ? SizedBox(
                        height: 0,
                      )
                    : Wrap(
                        children: List.generate(5, (index) {
                          return Container(
                            margin: EdgeInsets.only(right: size.height * 0.01),
                            child: ClearButton(
                              text: (index + date.day).toString(),
                              color: selected == index
                                  ? Colors.white
                                  : Colors.black,
                              size: size.width * 0.15,
                              borderColor:
                                  selected == index ? Colors.black : purple,
                              backgroundColor: selected == index
                                  ? Colors.black
                                  : lightPurple,
                              press: () {
                                setState(() {
                                  selected = index;
                                });
                              },
                            ),
                          );
                        }),
                      )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  height: widget.isProfile ? 130 : 54,
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
                  child: !widget.isProfile
                      ? TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle:
                                TextStyle(color: darkPurple.withOpacity(0.5)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            suffixIcon: GestureDetector(
                                child: Icon(Icons.search),
                              onTap: (){},
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            TextRich(
                              title: 'Completed',
                              tasks_nb: 5,
                              color: Colors.green,
                            ),
                            Spacer(),
                            TextRich(
                              title: 'Snoozed',
                              tasks_nb: 1,
                              color: Colors.orange,
                            ),
                            Spacer(),
                            TextRich(
                              title: 'Overdue',
                              tasks_nb: 2,
                              color: Colors.red,
                            ),
                          ],
                        )))
        ],
      ),
    );
  }
}
