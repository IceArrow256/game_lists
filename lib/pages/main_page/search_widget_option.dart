import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SearchWidgetOption extends StatefulWidget {
  @override
  _SearchWidgetOptionState createState() => _SearchWidgetOptionState();
}

class _SearchWidgetOptionState extends State<SearchWidgetOption> {
  var textEditingController = TextEditingController(text: 'nier');
  Uri? _url;

  @override
  Widget build(BuildContext context) {
    _url = Uri.http(
        '192.168.0.2:8000', '/search', {'query': textEditingController.text});
    print(_url);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: textEditingController,
            autofocus: true,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for game to add...'),
          ),
          FutureBuilder<http.Response>(
            future: http.get(_url!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data =
                    convert.jsonDecode(snapshot.data!.body) as List<dynamic>;
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(data.elementAt(index)['name']),
                        ),
                      );
                    },
                  ),
                );
              }
              return Center(child: Text('Please Wait...'));
            },
          )
        ],
      ),
    );
  }
}
