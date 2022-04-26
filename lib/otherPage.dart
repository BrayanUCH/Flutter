import 'package:flutter/material.dart';
import 'package:notifications/utils/color_utils.dart';

class otherPage extends StatelessWidget {
  final String payload;
  //notifications().cancelAllNotifications();
  const otherPage({Key key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("other Page"),
        centerTitle: true,
        backgroundColor: hexStringToColor("ffc362"),
      ),
      body: Container(
         decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("ffc362"),
          hexStringToColor("ffab62"),
          hexStringToColor("ff9262")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              payload ?? '',
              style: TextStyle(fontSize: 35),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'payload',
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}
