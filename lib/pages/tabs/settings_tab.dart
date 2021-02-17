import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class SettingsTab extends StatefulWidget {
  final bool isDarkTheme;
  final ValueChanged<bool> updateIsDarkTheme;

  const SettingsTab(
      {Key key, @required this.isDarkTheme, @required this.updateIsDarkTheme})
      : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String _appName;
  String _version;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 4,
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Appearance',
                  style: TextStyle(fontSize: 16),
                ),
                SwitchListTile(
                    title: Text('Dark Theme'),
                    value: widget.isDarkTheme,
                    onChanged: (value) {
                      widget.updateIsDarkTheme(value);
                    }),
              ],
            ),
          ),
        ),
        Center(
          child: Text('$_appName $_version'),
        ),
      ],
    );
  }

  _getVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appName = packageInfo.appName;
      _version = packageInfo.version;
    });
  }

  @override
  void initState() {
    _appName = '';
    _version = '';
    _getVersion();
    super.initState();
  }
}
