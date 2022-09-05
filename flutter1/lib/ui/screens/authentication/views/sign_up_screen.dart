import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/authentication_provider.dart';
import 'package:flutter1/ui/screens/authentication/views/sign_in_screen.dart';
import 'package:flutter1/ui/screens/authentication/widgets/have_an_account.dart';
import 'package:flutter1/ui/screens/authentication/widgets/background.dart';
import 'package:flutter1/ui/screens/shared/widgets/bottom_navigation_bar.dart';
import 'package:flutter1/ui/screens/shared/widgets/button.dart';
import 'package:flutter1/ui/screens/shared/widgets/field.dart';
import 'package:flutter1/ui/screens/shared/widgets/form_validation.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String email, password, username, age;
  final GlobalKey<FormState> _key = GlobalKey();
  bool isObscure = true;
  String data = "";
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
              Text(
                data,
                style: TextStyle(color: Colors.red),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignInScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: size.height * 0.01),
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
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: size.height * 0.01),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 2.0, color: darkPurple))),
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
              SizedBox(height: size.height * 0.05),
              const Text(
                " Create An Account",
                style: TextStyle(
                  color: lightBlack,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Field(
                validate: FormValidation().validateName,
                icon: Icons.person,
                hintText: "Username",
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    username = value.trim();
                  });
                },
              ),
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
                validate: FormValidation().validateAge,
                icon: Icons.calendar_today_outlined,
                hintText: "Age",
                keyboardType: TextInputType.number,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    age = value.trim();
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
              Field(
                validate: FormValidation().validateConfirm,
                icon: Icons.lock,
                hintText: "Confirm Password",
                obscureText: true,
              ),
              SizedBox(height: size.height * 0.03),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Button(
                      width: size.width * 0.8,
                      text: "SIGN UP",
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          authentication.signUp(email, password, username, age);
                          if (authentication.error == "") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return NavigationBar1();
                                },
                              ),
                            );
                          } else {
                            setState(() {
                              data = authentication.error;
                            });
                          }
                        } else
                          print('nope');
                      }),
                  HaveAnAccount(
                    login: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignInScreen();
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
