import 'package:flutter/material.dart';
import 'package:game_lists/pages/select_pages/select_page.dart';

class SelectSeriesPage extends StatefulWidget {
  @override
  _SelectSeriesPageState createState() => _SelectSeriesPageState();
}

class _SelectSeriesPageState extends State<SelectSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return SelectPage(
      title: 'Series',
      addRoute: '/series',
      body: Center(child: Text('To-do')),
    );
  }
}
