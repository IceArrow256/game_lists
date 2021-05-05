import 'package:flutter/material.dart';
import 'package:game_lists/model/developer.dart';
import 'package:game_lists/pages/add_edit_pages/add_edit_page.dart';
import 'package:hive/hive.dart';

class CompanyPage extends StatefulWidget {
  static const routeName = '/company';
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final _formKey = GlobalKey<FormState>();
  int? _key;
  String? _name;
  String? _country;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      // var company = ModalRoute.of(context)!.settings.arguments as Company;
      // _key = company.key;
      // _name = company.name;
      // _country = company.country;
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(_key == null ? Icons.add : Icons.check),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // var companyBox = await Hive.openBox<Company>('company');
            // var company = Company(_name!, _country!);
            if (_key == null) {
              // await companyBox.add(company);
            } else {
              // await companyBox.put(_key, company);
            }
            Navigator.pop(context);
          }
        },
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(_key == null ? 'Add Company' : 'Edit Company'),
        actions: _key != null
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // var companyBox = await Hive.openBox<Company>('company');
                    // await companyBox.delete(_key);
                    Navigator.pop(context);
                  },
                ),
              ]
            : null,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(
                icon: Icon(Icons.label_important),
                labelText: 'Name',
              ),
              onSaved: (value) {
                _name = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _country,
              decoration: const InputDecoration(
                icon: Icon(Icons.flag),
                labelText: 'Country',
              ),
              onSaved: (value) {
                _country = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
