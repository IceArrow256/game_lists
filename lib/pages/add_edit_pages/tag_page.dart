import 'package:flutter/material.dart';
import 'package:game_lists/pages/add_edit_pages/add_edit_page.dart';

class TagPage extends StatefulWidget {
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AddEditPage(
      title: 'Tag',
      formChildren: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.label_important),
            hintText: 'Name of the Tag',
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
