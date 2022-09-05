import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';

class TitleTask extends StatelessWidget {
  const TitleTask({
    Key? key,
    this.press,
    this.title = "Tasks",
    this.isTask =true,
  }) : super(key: key);
  final VoidCallback? press ;
  final String? title;
  final bool isTask ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: size.width *0.07),
      child: Row(
        children: [
          Container(
            height: 24,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.02),
                  child: Text(
                    title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    height: 7,
                    color: darkPurple.withOpacity(0.2),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          isTask ? FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: purple,
            onPressed: press,
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          ): SizedBox(height: 0,),
        ],
      ),
    );
  }
}