import 'package:flutter/material.dart';
import 'package:game_lists/database/database.dart';
import 'package:game_lists/database/entities/country.dart';
import 'package:game_lists/pages/select_pages/select_page.dart';
import 'package:provider/provider.dart';

class SelectCountryPage extends StatefulWidget {
  @override
  _SelectCountryPageState createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<GameListsDatabase>(context, listen: false);
    var _countryDao = database.countryDao;
    return SelectPage(
      title: 'Country',
      addRoute: '/country',
      body: FutureBuilder<List<Country>>(
        future: _countryDao.findWithNamesLike('%%'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Fuck');
            print(DateTime.now());

            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(title: Text(snapshot.data![index].name)));
              },
            );
          }
          return Center(child: Text('Please Wait!'));
        },
      ),
      setParentState: () {
        setState(() {
        });
      },
    );
  }
}
