import 'package:flutter/material.dart';
import 'package:game_lists/pages/select_pages/select_page.dart';

class SelectTagPage extends StatefulWidget {
  @override
  _SelectTagPageState createState() => _SelectTagPageState();
}

class _SelectTagPageState extends State<SelectTagPage> {
  @override
  Widget build(BuildContext context) {
    return SelectPage(
      title: 'Tag',
      addRoute: '/tag',
      body: Center(child: Text('To-do')),
    );
  }
}
