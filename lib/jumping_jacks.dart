import 'package:flutter/material.dart';
//import 'package:flutter_poc_gyroscope/pages/home_page.dart';
import 'package:sensors_plus/sensors_plus.dart';

class JumpingJackCheck extends StatefulWidget {
  const JumpingJackCheck({super.key});

  @override
  
  _JumpingJackCheckState createState() => _JumpingJackCheckState();
}

class _JumpingJackCheckState extends State<JumpingJackCheck> {
  double? _lastPeakTime = 0;
  int _jumpingJackCount = 0;
  List<double>? _accelerometerValues;

  //Later _threshhold aanpassen wanneer er concreet een cijfer gekozen is dit het beste past bij de jumping jack beweging,
  final double _threshold = 15.0;
  final double _minInterval = 1.0;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _detectJumpingJack(event.z);
         _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    });
  }

  void _detectJumpingJack(double zValue) {
    double currentTime = DateTime.now().millisecondsSinceEpoch / 1000;
    
    //Dit kan een mogelijkheid zijn om te zeggen dat dit nep is:
    if (zValue.abs() > _threshold && zValue.abs() < 17 ) {
      if (currentTime - (_lastPeakTime ?? 0) > _minInterval) {        
        _jumpingJackCount++;
        _lastPeakTime = currentTime;
      }
    }
    // Algoritme valsspelen aan te pakken
    // if (yValue.abs() > _cheatingThreshold) {
    //   if (currentTime - (_lastPeakTime ?? 0) > _minInterval) {        
    //     _jumpingJackCount--;
    //     _lastPeakTime = currentTime;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer = _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Jumping Jacks Checks'))),
        // body: Center(
        //   child: Text('Jumping Jacks Counted: $_jumpingJackCount' ' \n ' 'Accelerometer: $accelerometer'),
        //   ElevatedButton
        // ),
        body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Jumping Jacks Counted: $_jumpingJackCount' ' \n ' 'Accelerometer: $accelerometer'),            
          ],
        ),
      ),
      ),
    );
  }
}
