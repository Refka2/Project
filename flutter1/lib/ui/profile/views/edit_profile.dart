import 'package:flutter/material.dart';
import 'package:flutter1/ui/shared/widgets/button.dart';
import 'package:flutter1/ui/shared/widgets/form_validation.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _key = GlobalKey();
  bool showPassword = false;
  String? validatePassword(String? value){

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

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField, FormFieldValidator<String> validate){
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        validator: validate,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: darkerPurple),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            suffixIcon:  isPasswordTextField? IconButton(
              onPressed: (){
                setState(() {
                  showPassword =! showPassword;
                });
              },
              icon: const Icon(
                Icons.visibility,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: darkerPurple,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )
        ),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: darkPurple,
          ),
          onPressed: (){},
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.settings,
                color: darkPurple,
              ),
          )
        ],
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                const Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: lightGray,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox( height: 15,),
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
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0,10)
                            )
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/avatar_girl.png",
                            ),
                          )
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: ()=>{},
                          child: Container(
                            height: size.width *0.1,
                            width: size.width *0.12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
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
                const SizedBox(height: 35,),
                buildTextField("UserName", "Name", false,FormValidation().validateName),
                buildTextField("Email", "Name@gmail.com", false,FormValidation().validateEmail),
                buildTextField("Age", "30", false,FormValidation().validateAge),
                buildTextField("Password", "*********", true,validatePassword),
                const SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                        text: "CANCEL",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: size.width *0.38,
                      color: Colors.black,
                    ),
                    Button(
                        width: size.width *0.38,
                        text: "SAVE",
                        onPressed:()=>{
                          if(_key.currentState!.validate()){
                            print ('success')}
                          else
                            print('nope'),
                        }
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
