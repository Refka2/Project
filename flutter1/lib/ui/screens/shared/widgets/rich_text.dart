import 'package:flutter/material.dart';
import 'package:flutter1/ui/ui_utils/ui_colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TextRich extends StatelessWidget {
  const TextRich({
    Key? key,
    required this.title,
    required this.tasks_nb,
    required this.color,
  }) : super(key: key);
  final String title;
  final double tasks_nb;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n".toUpperCase(),
                  style: Theme.of(context).textTheme.button,
                ),

                TextSpan(
                    text: "${tasks_nb.toInt()} tasks",
                    style: TextStyle(
                      color: lightBlack.withOpacity(0.5),
                    )
                ),
              ]

          ),

        ),
        CircularPercentIndicator(
          radius: 25.0,
          lineWidth: 4.0,
          percent: tasks_nb /8 ,
          center: new Text("${(tasks_nb.toInt()/8)*100}"),
          progressColor: color,
        ),
      ],
    );
  }
}