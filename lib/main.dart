import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Game List';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
            title: Row(
          children: [Icon(Icons.gamepad), SizedBox(width: 8), Text(title)],
        )),
        body: Image.network(
            'https://i.pinimg.com/originals/53/f9/8a/53f98a6b76f60356b2b4c261963377e6.jpg'),
      ),
    );
  }
}
