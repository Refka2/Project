import 'package:flutter/material.dart';
import 'package:flutter1/ui/profile/widgets/gray_text.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints( minHeight: size.height),
          child: IntrinsicHeight(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                      purple,
                      lightPurple,
                      ],
                  begin: FractionalOffset(0.0, 0.3),
                  end: Alignment.topRight,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                width: size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 25,

                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 25,

                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: purple,
                        radius: size.height * 0.09,
                        child: CircleAvatar(
                          backgroundColor: lightPurple,
                          radius: size.height * 0.09 -2,
                          child: CircleAvatar(
                            backgroundImage: const AssetImage(
                              "assets/images/avatar_girl.png",
                            ),
                            radius: size.height * 0.09 -4,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    const Text(
                      "UserName",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top:50, left: 20, right: 20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40),
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GrayText(
                              text: "Edit Profile",
                              icon: Icons.person,
                              onPressed: () => Navigator.pop(context),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Align(
                              alignment: Alignment.center,
                              child: GrayText(
                                text: "Progress",
                                icon: Icons.trending_up_outlined,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            GrayText(
                              text: "Favourites",
                              icon: Icons.favorite,
                              onPressed: () => Navigator.pop(context),
                            ),
                            SizedBox(height: size.height * 0.01),
                            GrayText(
                              text: "Settings",
                              icon: Icons.settings,
                              onPressed: () => Navigator.pop(context),
                            ),
                            SizedBox(height: size.height * 0.01),
                            GrayText(
                              text: "LogOut",
                              icon: Icons.logout,
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
      ),
    );
  }
}
