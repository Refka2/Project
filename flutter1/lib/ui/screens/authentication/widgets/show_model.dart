import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/authentication_provider.dart';
import 'package:flutter1/ui/screens/shared/widgets/button.dart';
import 'package:flutter1/ui/screens/shared/widgets/field.dart';
import 'package:flutter1/ui/screens/shared/widgets/form_validation.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:provider/provider.dart';

import 'model_reset_password.dart';
class ShowModel extends StatefulWidget {
  const ShowModel({Key? key}) : super(key: key);

  @override
  State<ShowModel> createState() => _ShowModelState();
}

class _ShowModelState extends State<ShowModel> {

  late String _email;
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    final AuthenticationProvider authentication =
    Provider.of<AuthenticationProvider>(context);
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Theme.of(context).backgroundColor,
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
                  Text(
                    "Enter your Email for the verification process.",
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 15,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    width: size.width,
                    child: Form(
                      key: _key,
                      child: Field(
                        validate: FormValidation().validateEmail,
                        icon: Icons.email ,
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        onChanged: (val)=> setState(() {
                          _email = val;
                        })
                      ),
                    ),
                  ),
                  Button(
                    text: "Send",
                    width: size.width *0.8,
                    onPressed: () {
                      if(_key.currentState!.validate()){
                        authentication.resetPassword(email: _email);
                        Navigator.pop(context);
                        // showModalBottomSheet<void>(
                        //   context: context,
                        //   isScrollControlled: true,
                        //   builder: (BuildContext context) {
                        //
                        //     return ResetPassword();
                        //   },
                        // );
                      }
                      else
                        print('nope');

                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

