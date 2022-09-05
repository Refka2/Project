import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/ui/screens/home/widgets/header.dart';
import 'package:flutter1/ui/screens/profile/views/edit_profile.dart';
import 'package:flutter1/ui/screens/profile/widgets/favourites.dart';
import 'package:flutter1/ui/screens/profile/widgets/gray_text.dart';
import 'package:flutter1/ui/screens/settings/views/settings.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
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
            return Scaffold(
              body: Column(
                children: [
                  Header(
                    isHome: true,
                    isProfile: true,
                    username: data['username'],
                    email: data['email'],
                    imageUrl: data['imageUrl'],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.2, right: size.width * 0.08),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GrayText(
                          text: "Edit Profile",
                          icon: Icons.person,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const EditProfile();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        GrayText(
                          text: "Favourites",
                          icon: Icons.favorite,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Favourites();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        GrayText(
                          text: "Settings",
                          icon: Icons.settings,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Setting();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
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
