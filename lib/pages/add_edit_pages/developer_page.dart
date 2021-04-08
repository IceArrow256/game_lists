import 'package:flutter/material.dart';
import 'package:game_lists/pages/add_edit_pages/add_edit_page.dart';

class DeveloperPage extends StatefulWidget {
  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AddEditPage(
      title: 'Developer',
      formChildren: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.label_important),
            hintText: 'Name of the Developer',
            labelText: 'Name',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.developer_board),
            hintText: 'Country of the Developer',
            labelText: 'Country',
          ),
          initialValue: 'Ukraine',
          onTap: () {
            Navigator.pushNamed(context, '/select_country');
          },
          readOnly: true,
        ),
      ],
      formKey: _formKey,
      onPressed: () {

      },
    );
  }
}
