import 'package:flutter/material.dart';
import 'package:game_lists/pages/select_pages/select_page.dart';

class SelectDeveloperPage extends StatefulWidget {
  @override
  _SelectDeveloperPageState createState() => _SelectDeveloperPageState();
}

class _SelectDeveloperPageState extends State<SelectDeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return SelectPage(
      title: 'Developer',
      addRoute: '/developer',
      body: Center(child: Text('To-do')),
    );
  }
}
