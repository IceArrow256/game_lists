import 'package:flutter/material.dart';

class AddEditPage extends StatefulWidget {
  AddEditPage({
    Key? key,
    required this.title,
    required this.formChildren,
    required this.formKey,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final List<Widget> formChildren;
  final GlobalKey<FormState> formKey;
  final VoidCallback? onPressed;

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: widget.onPressed,
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text('Add ' + widget.title),
      ),
      body: Form(
        key: widget.formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: widget.formChildren,
        ),
      ),
    );
  }
}
