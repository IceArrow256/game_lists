import 'package:flutter/material.dart';
import 'package:game_lists/database/dao/country_dao.dart';
import 'package:game_lists/database/database.dart';
import 'package:game_lists/database/entities/country.dart';
import 'package:game_lists/pages/add_edit_pages/add_edit_page.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isNameInDatabase = false;
  CountryDao? _countryDao;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final database = Provider.of<GameListsDatabase>(context, listen: false);
      _countryDao = database.countryDao;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddEditPage(
      title: 'Country',
      formChildren: [
        TextFormField(
          controller: _nameController,
          autofocus: true,
          decoration: const InputDecoration(
            icon: Icon(Icons.label_important),
            hintText: 'The name of the country',
            labelText: 'Name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            } else if (_isNameInDatabase) {
              return 'The country in database';
            }
            return null;
          },
        ),
      ],
      formKey: _formKey,
      onPressed: () async {
        var name = _nameController.value.text;
        var countries = await _countryDao!.findWithNames(name);
        _isNameInDatabase = countries.isNotEmpty;
        if (_formKey.currentState!.validate()) {
          var country = Country(null, name);
          await _countryDao!.insertCountry(country);
          Navigator.pop(context);
        }
      },
    );
  }
}
