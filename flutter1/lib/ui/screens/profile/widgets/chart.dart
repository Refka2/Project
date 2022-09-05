import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(size.height *0.1),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 4.0,
              percent: 0.10,
              center: new Text("10%"),
              progressColor: Colors.green,
            ),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            new CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 4.0,
              percent: 0.30,
              center: new Text("30%"),
              progressColor: Colors.orange,
            ),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            new CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 4.0,
              percent: 0.60,
              center: new Text("60%"),
              progressColor: Colors.red,
            ),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            new CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 4.0,
              percent: 0.90,
              center: new Text("90%"),
              progressColor: Colors.green,
            )
          ],
        ));
  }
}
