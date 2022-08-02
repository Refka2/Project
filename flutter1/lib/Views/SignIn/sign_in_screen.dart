import 'package:flutter/material.dart';
import 'package:flutter1/Views/SignUp/background.dart';
import 'package:flutter1/Views/SignUp/button.dart';
import 'package:flutter1/Views/SignUp/field.dart';
import 'package:flutter1/Views/SignUp/form_validation.dart';
import 'package:flutter1/Views/SignUp/have_an_account.dart';
import 'package:flutter1/Views/SignUp/sign_up_screen.dart';

import '../../colors.dart';
import '../../colors.dart';
import 'forget_password.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  String? _validatePassword(String? value){

    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if(value!.isEmpty) {
      return 'Required Field';
    } else if(!regExp.hasMatch(value)) {
      return 'Password too weak';
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Background(
      child: Form(
      key: _key,
      child :Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () { },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 2.0, color: darkPurple)
                          )
                      ),
                      child: const Text(
                        " Sign In",
                        style: TextStyle(
                          color: darkPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),
                SizedBox(width: size.width * 0.04),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return const SignUpScreen();
                        },
                      ),
                    );
                  },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                          color: darkPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),

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
              icon: Icons.email ,
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
            ),
            Field(
              validate: _validatePassword,
              icon: Icons.lock ,
              hintText: "Password",
              obscureText: true,

              // onPressed: () =>{
              //   isObscure= ! isObscure
              //   Icon(isObscure ?Icons.visibility_off : Icons.visibility)
              // },
              suffixIcon: Icons.visibility_off,
            ),
            SizedBox(height: size.height * 0.03),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: size.height *  0.5,
                          color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                          Icons.close,
                                          color: lightBlack,
                                      ),
                                    )
                                ),
                                const Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    color: lightBlack,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Field(
                                  validate: FormValidation().validateEmail,
                                  icon: Icons.email ,
                                  hintText: "Email",
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                Button(
                                  text: "Send",
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                        );
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
                    text: "SIGN IN",
                    onPressed:()=>{
                      if(_key.currentState!.validate()){
                        print ('success')}
                      else
                        print('nope'),
                    }
                ),
                HaveAnAccount(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
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
    ),);
  }
}
