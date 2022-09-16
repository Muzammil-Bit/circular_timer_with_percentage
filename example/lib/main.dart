import 'package:example/timer_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Progress Indicator With Percentage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circular Progress"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[400],
      body: Center(
        child: CircularTimerWithProgress(
          width: 200,
          duration: 50,
          autoStart: true,
          // isReverse: true,
          innerFillColor: Colors.white,
          outerStrokeColor: Colors.black,
          textFormat: TextFormat.MM_SS,
          percentageBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
