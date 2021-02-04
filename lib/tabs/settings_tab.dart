import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab(
      {Key key, @required this.isDarkTheme, @required this.updateIsDarkTheme})
      : super(key: key);

  final bool isDarkTheme;
  final ValueChanged<bool> updateIsDarkTheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 8,
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Appearance'),
                SwitchListTile(
                    title: Text('Dark Theme'),
                    value: isDarkTheme,
                    onChanged: (value) {
                      updateIsDarkTheme(value);
                    })
              ],
            ),
          ),
        )
      ],
    );
  }
}
