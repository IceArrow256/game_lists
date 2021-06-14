import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(children: [
        Text(
          'Developed by IceArrow256\nSpecial thanks to Giant Bomb\n',
          textAlign: TextAlign.center,
        ),
        TextField(onChanged: (host) async {
          var hostBox = await Hive.openBox<String>('host');
          hostBox.put('host', host);
        }),
      ]),
    );
  }
}
