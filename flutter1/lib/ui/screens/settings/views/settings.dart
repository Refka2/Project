
import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/authentication_provider.dart';
import 'package:flutter1/ui/screens/authentication/views/sign_in_screen.dart';
import 'package:flutter1/ui/screens/authentication/widgets/model_reset_password.dart';
import 'package:flutter1/ui/screens/settings/widgets/build_account_option.dart';
import 'package:flutter1/ui/screens/settings/widgets/build_notification_option.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var auth = new AuthenticationProvider();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: darkerPurple,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: size.width * 0.06, top:size.height * 0.02, right: size.width * 0.06),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: darkPurple,
                ),
                SizedBox(width:size.width *0.02),
                Text(
                  "Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Divider(height: size.height *0.016, thickness: 2),
            SizedBox(height: size.height *0.01),
            BuildAccountOption(context: context, title: "Change password",
                press: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {

                        return ResetPassword();
                      },
                    );
                },
            ),
            BuildAccountOption(context: context, title: "Color Theme", press: (){}),
            BuildAccountOption(context: context, title: "Language", press: (){}),
            SizedBox(height: size.height *0.07),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: darkPurple,
                ),
                SizedBox(width: size.width *0.02),
                Text(
                    "Notifications",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(height: size.height *0.016, thickness: 2),
            SizedBox(height: size.height *0.01),
            BuildNotificationOption(title: "Dark Mode", isActive: false),
            SizedBox(height: size.height *0.08),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width *0.08),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => {
                    auth.logOut(),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return SignInScreen();
                        },
                      ),
                    ),
                  },
                  child: Text(
                    "SIGN OUT",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2.2,
                      color: darkPurple,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




