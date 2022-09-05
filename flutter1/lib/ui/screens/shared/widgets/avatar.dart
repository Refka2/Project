import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/core/models/user_model.dart';
import 'package:flutter1/core/providers/authentication_provider.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:provider/provider.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.username,
    this.email,
    this.imageUrl,
  }) : super(key: key);
  final String? username;
  final String? email;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final AuthenticationProvider authentication =
        Provider.of<AuthenticationProvider>(context);
    Size size = MediaQuery.of(context).size;
    // return FutureBuilder<DocumentSnapshot>(
    //     future: FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(currentUser?.uid)
    //         .get(),
    //     builder: (context, snapshot) {
    //       Map<String, dynamic> data =
    //           snapshot.data?.data() as Map<String, dynamic>;
          return Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: purple,
                  radius: size.height * 0.07,
                  child: CircleAvatar(
                    backgroundColor: lightPurple,
                    radius: size.height * 0.07 - 2,
                    child: CircleAvatar(
                      // backgroundImage: const AssetImage(
                      //   "assets/avatar_girl.webp",
                      // ),
                      backgroundImage: NetworkImage(
                        imageUrl ?? ""
                      ),
                      radius: size.height * 0.07 - 4,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                username ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
               Text(
                email ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          );
        // });
  }
}
