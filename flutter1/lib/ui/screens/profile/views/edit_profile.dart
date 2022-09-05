import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/core/models/user_model.dart';
import 'package:flutter1/core/providers/authentication_provider.dart';
import 'package:flutter1/ui/screens/profile/widgets/build_text_field.dart';
import 'package:flutter1/ui/screens/settings/views/settings.dart';
import 'package:flutter1/ui/screens/shared/widgets/button.dart';
import 'package:flutter1/ui/screens/shared/widgets/form_validation.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  UserModel? data;
  void _getData()  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        data = UserModel.fromFirestore(value.data());
      });
    });
  }
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    usernameController.addListener(_ChangeName);
    emailController.addListener(_ChangeEmail);
    ageController.addListener(_ChangeAge);
    _getData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    usernameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void _ChangeName() {
    setState(() => _currentName = usernameController.text);
  }

  void _ChangeEmail() {
    setState(() => _currentEmail = emailController.text);
  }

  void _ChangeAge() {
    setState(() => _currentAge = ageController.text);
  }

  final GlobalKey<FormState> _key = GlobalKey();
  bool showPassword = false;
  String _currentName = "";
  String _currentAge = "";
  String _currentEmail = "";
  String _imageUrl = "";
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final AuthenticationProvider authentication =
        Provider.of<AuthenticationProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: darkPurple,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Setting();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: darkPurple,
              ),
            )
          ],
        ),
        body: data==null?
        Center(
          child: CircularProgressIndicator(
            color: lightPurple,
          ),
        ): Form(
          key: _key,
          child: Container(
            padding: EdgeInsets.only(
                left: size.width * 0.05,
                top: size.width * 0.05,
                right: size.width * 0.05),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: lightBlack,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.width * 0.05),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: size.width * 0.35,
                          height: size.width * 0.35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: Colors.white,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color:
                                    Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (data?.imageUrl != null)? NetworkImage(
                                      data?.imageUrl??''
                                ): NetworkImage('https://firebasestorage.googleapis.com/v0/b/todoapp-2e3f4.appspot.com/o/images%2Favatar_girl.webp?alt=media&token=9286488a-8c55-4aac-937b-042d986ea09c')
                                  ),),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              await authentication.uploadImage();
                              setState(() {
                                _imageUrl = authentication.url;
                              });
                            },
                            child: Container(
                              height: size.width * 0.1,
                              width: size.width * 0.12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                ),
                                color: darkPurple,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.width * 0.1),
                  BuildTextField(
                    showPassword: showPassword,
                    labelText: "UserName",
                    placeholder: data?.username ?? "",
                    isPasswordTextField: false,
                    validate: FormValidation().UpdateName,
                    controller: usernameController,
                  ),
                  BuildTextField(
                    showPassword: showPassword,
                    labelText: "Email",
                    placeholder: data?.email ?? "",
                    isPasswordTextField: false,
                    validate: FormValidation().UpdateEmail,
                    controller: emailController,
                  ),
                  BuildTextField(
                    showPassword: showPassword,
                    labelText: "Age",
                    placeholder: data?.age?? "",
                    isPasswordTextField: false,
                    validate: FormValidation().UpdateAge,
                    controller: ageController,
                  ),
                  SizedBox(height: size.width * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        text: "CANCEL",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: size.width * 0.38,
                        color: purple.withOpacity(0.3),
                        textColor: lightBlack,
                      ),
                      Button(
                          width: size.width * 0.38,
                          text: "SAVE",
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              await authentication.updateUserData(
                                  _currentName == ""
                                      ? data?.username
                                      : _currentName,
                                  _currentEmail == ""
                                      ? data?.email
                                      : _currentEmail,
                                  _currentAge == ""
                                      ? data?.age
                                      : _currentAge,
                                  _imageUrl == ""
                                      ? data?.imageUrl
                                      : _imageUrl,
                                  data?.userId);
                              Navigator.pop(context);
                            } else
                              print('nope');
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
