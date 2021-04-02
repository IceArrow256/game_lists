import 'package:flutter/material.dart';

class SearchWidgetOption extends StatefulWidget {
  @override
  _SearchWidgetOptionState createState() => _SearchWidgetOptionState();
}

class _SearchWidgetOptionState extends State<SearchWidgetOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            onChanged: (String query) {
              print(query);
            },
            autofocus: true,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for game to add...'),
          ),
        ],
      ),
    );
  }
}
