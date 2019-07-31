import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_analytics/text_heat_map/heatmap_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout tests'),
        ),
        body: ListView(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Placeholder(
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Placeholder(
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: Placeholder(
                    color: Colors.blue,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
