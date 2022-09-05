import 'package:flutter/material.dart';
import 'package:flutter1/ui/screens/shared/widgets/button.dart';
import 'package:flutter1/ui/screens/shared/widgets/field.dart';
import 'package:flutter1/ui/screens/shared/widgets/form_validation.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Theme.of(context).primaryColor,
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
              padding: EdgeInsets.only(left: size.height * 0.02),
              child: Column(
                children: [
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      color: lightBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                   Text(
                    "Set the new password for your account.",
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 15,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),


            Form(
                key: _key,
               child: Column(
                 children: [
                   SizedBox(
                    width: size.width,
                    child: Field(
                      validate: FormValidation().validatePassword,
                      icon: Icons.lock ,
                      hintText: "Password",
                      obscureText: true,
                    ),
              ),
              SizedBox(
                    width: size.width,
                    child: Field(
                      validate: FormValidation().validateConfirm,
                      icon: Icons.lock ,
                      hintText: "Confirm Password",
                      obscureText: true,
                    ),
              ),
                    Button(
                      width: size.width *0.8,
                      text: "Reset Password",
                        onPressed:()=>{
                          if(_key.currentState!.validate()){
                            Navigator.pop(context)
                          }
                          else
                            print('nope'),
                        },
                    ),
                 ],
               )
            ),


          ],
        ),
      ),
    );
  }
}
