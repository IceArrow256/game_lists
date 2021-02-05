import 'package:flutter/material.dart';

import 'package:game_list/db/database.dart';
import 'package:game_list/db/person.dart';

class GamesTab extends StatefulWidget {
  @override
  _GamesTabState createState() => _GamesTabState();
}

class _GamesTabState extends State<GamesTab> {
  void test() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('game_list.db').build();

    final personDao = database.personDao;
    final person = Person(null, 'Frank');

    await personDao.insertPerson(person);
    final result = personDao.findPersonById(1);
    var test = await result.first;
    print(test.name);
  }

  @override
  void initState() {
    test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [],
    ));
  }
}
