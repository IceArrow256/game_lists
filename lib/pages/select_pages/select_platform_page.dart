import 'package:flutter/material.dart';
import 'package:game_lists/pages/select_pages/select_page.dart';

class SelectPlatformPage extends StatefulWidget {
  @override
  _SelectPlatformPageState createState() => _SelectPlatformPageState();
}

class _SelectPlatformPageState extends State<SelectPlatformPage> {
  @override
  Widget build(BuildContext context) {
    return SelectPage(
      title: 'Platform',
      addRoute: '/platform',
      body: Center(child: Text('To-do')),
    );
  }
}
