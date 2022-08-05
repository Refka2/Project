import 'package:flutter/material.dart';
import 'package:flutter1/ui/authentication/views/sign_in_screen.dart';
import 'package:flutter1/ui/authentication/widgets/have_an_account.dart';
import 'package:flutter1/ui/shared/widgets/background.dart';
import 'package:flutter1/ui/shared/widgets/button.dart';
import 'package:flutter1/ui/shared/widgets/field.dart';
import 'package:flutter1/ui/shared/widgets/form_validation.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

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
  String? validateConfirm(String? value){
    if(value!.isEmpty) {
      return 'Required Field';
    } else if(!( value == confirmPass)) {
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
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context){
                             return const SignInScreen();
                           },
                         ),
                       );
                     },
                       child: Container(
                         padding: const EdgeInsets.only(bottom: 10),
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
                     onTap: () { },
                       child: Container(
                         padding: const EdgeInsets.only(bottom: 10),
                         decoration: const BoxDecoration(
                             border: Border(
                                 bottom: BorderSide(width: 2.0, color: darkPurple)
                             )
                         ),
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
                " Create An Account",
                style: TextStyle(
                  color: lightBlack,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Field(
                validate: FormValidation().validateName,
                icon: Icons.person ,
                hintText: "Username",
      ),

              Field(
                validate: FormValidation().validateEmail,
                icon: Icons.email ,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),

              Field(
                validate: FormValidation().validateAge,
                icon: Icons.calendar_today_outlined ,
                hintText: "Age",
                keyboardType: TextInputType.number,
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
                suffixIcon: Icons.visibility_off ,
              ),
              Field(
                validate: validateConfirm,
                icon: Icons.lock ,
                hintText: "Confirm Password",
                obscureText: true,
                suffixIcon: Icons.visibility_off,
              ),
              SizedBox(height: size.height * 0.03),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Button(
                      width: size.width *0.8,
                      text: "SIGN UP",
                        onPressed:()=>{
                          if(_key.currentState!.validate()){
                            print ('success')}
                          else
                            print('nope'),
                        }
                  ),
                  HaveAnAccount(
                    login: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                      builder: (context){
                      return const SignInScreen();
                      },),
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
