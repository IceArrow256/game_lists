import 'package:flutter/material.dart';
import 'package:game_lists/pages/add_edit_pages/add_edit_page.dart';

class SeriesPage extends StatefulWidget {
  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AddEditPage(
      title: 'Series',
      formChildren: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.label_important),
            hintText: 'Name of the Series',
            labelText: 'Name',
          ),
        ),
      ],
      formKey: _formKey,
      onPressed: () {

      },
    );
  }
}
