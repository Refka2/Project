import 'package:flutter/material.dart';
import 'package:flutter1/ui/authentication/views/sign_up_screen.dart';
import 'package:flutter1/ui/authentication/widgets/have_an_account.dart';
import 'package:flutter1/ui/shared/widgets/background.dart';
import 'package:flutter1/ui/shared/widgets/button.dart';
import 'package:flutter1/ui/shared/widgets/field.dart';
import 'package:flutter1/ui/shared/widgets/form_validation.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  String? confirmPass;
  bool isObscure = true;

  String? validatePassword(String? value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if(value!.isEmpty) {
      return 'Required Field';
    } else if(!regExp.hasMatch(value)) {
      return 'Password too weak';
    } else {
      confirmPass= value;
      return null;
    }
  }
  String? validateConfirm(String? value) {
    if (value!.isEmpty) {
      return 'Required Field';
    } else if (!(value == confirmPass)) {
      return 'Password Does not match';
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
                      decoration: BoxDecoration(
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
              validate: validatePassword,
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
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
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
                                  Container(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Forgot Password",
                                          style: TextStyle(
                                            color: lightBlack,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        const Text(
                                          "Enter your Email for the verification process.",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            //fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(
                                          width: size.width,
                                          child: Field(
                                            validate: FormValidation().validateEmail,
                                            icon: Icons.email ,
                                            hintText: "Email",
                                            keyboardType: TextInputType.emailAddress,
                                          ),
                                        ),
                                        Button(
                                          text: "Send",
                                          width: size.width *0.8,
                                          onPressed: () => showModalBottomSheet<void>(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: size.height *  0.5,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
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
                                                      "Reset Password",
                                                      style: TextStyle(
                                                        color: lightBlack,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: size.height * 0.02),
                                                    const Text(
                                                      "Set the new password for your account.",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        //fontWeight: FontWeight.bold,
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: size.width,
                                                      child: Field(
                                                        validate: validatePassword,
                                                        icon: Icons.lock ,
                                                        hintText: "Password",
                                                        obscureText: true,
                                                        suffixIcon: Icons.visibility_off ,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width,
                                                      child: Field(
                                                        validate: validateConfirm,
                                                        icon: Icons.lock ,
                                                        hintText: "Confirm Password",
                                                        obscureText: true,
                                                        suffixIcon: Icons.visibility_off,
                                                      ),
                                                    ),
                                                    Button(
                                                      width: size.width *0.8,
                                                      text: "Reset Password",
                                                      onPressed: () => Navigator.pop(context),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                    width: size.width *0.8,
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
