import 'package:flutter/material.dart';
import 'package:game_lists/pages/add_edit_pages/add_edit_page.dart';

class PlatformPage extends StatefulWidget {
  @override
  _PlatformPageState createState() => _PlatformPageState();
}

class _PlatformPageState extends State<PlatformPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AddEditPage(
      title: 'Platform',
      formChildren: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.label_important),
            hintText: 'Name of the Platform',
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
