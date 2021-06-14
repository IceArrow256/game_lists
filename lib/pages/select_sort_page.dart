import 'package:flutter/material.dart';
import 'package:game_lists/pages/main_page/games_widget_option.dart';

class SelectSortPage extends StatelessWidget {
  static const routeName = '/selectSortPage';

  @override
  Widget build(BuildContext context) {
    final sorts = ModalRoute.of(context)!.settings.arguments as List<Sort>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Sort'),
      ),
      body: ListView.builder(
        itemCount: sorts.length,
        itemBuilder: (context, i) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {
                Navigator.pop(context, sorts[i]);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(sortToString(sorts[i])),
              ),
            ),
          );
        },
      ),
    );
  }
}
