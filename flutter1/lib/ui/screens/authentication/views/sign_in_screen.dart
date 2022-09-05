import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/authentication_provider.dart';
import 'package:flutter1/ui/screens/authentication/views/sign_up_screen.dart';
import 'package:flutter1/ui/screens/authentication/widgets/background.dart';
import 'package:flutter1/ui/screens/authentication/widgets/have_an_account.dart';
import 'package:flutter1/ui/screens/authentication/widgets/show_model.dart';
import 'package:flutter1/ui/screens/shared/widgets/bottom_navigation_bar.dart';
import 'package:flutter1/ui/screens/shared/widgets/button.dart';
import 'package:flutter1/ui/screens/shared/widgets/field.dart';
import 'package:flutter1/ui/screens/shared/widgets/form_validation.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String email, password;

  final GlobalKey<FormState> _key = GlobalKey();
  String? confirmPass;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AuthenticationProvider authentication =
        Provider.of<AuthenticationProvider>(context);
    return Background(
      child: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.04),
          child: ListView(
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: size.height * 0.01),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 2.0, color: darkPurple))),
                        child: const Text(
                          " Sign In",
                          style: TextStyle(
                            color: darkPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  SizedBox(width: size.width * 0.04),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignUpScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: size.height * 0.01),
                        child: const Text(
                          " Sign Up",
                          style: TextStyle(
                            color: darkPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(height: size.height * 0.15),
              const Text(
                " Welcome",
                style: TextStyle(
                  color: lightBlack,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Field(
                validate: FormValidation().validateEmail,
                icon: Icons.email,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    email = value.trim();
                  });
                },
              ),
              Field(
                validate: FormValidation().validatePassword,
                icon: Icons.lock,
                hintText: "Password",
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value.trim();
                  });
                },
              ),
              SizedBox(height: size.height * 0.03),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return ShowModel();
                        },
                      );
                    },
                    child: const Text(
                      " Forget Password ?",
                      style: TextStyle(
                        color: darkPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Button(
                      width: size.width * 0.8,
                      text: "SIGN IN",
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          authentication.signIn(email, password);
                          if (authentication.error == "") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return NavigationBar1();
                                },
                              ),
                            );
                          }
                        } else
                          print('nope');
                      }),
                  HaveAnAccount(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
