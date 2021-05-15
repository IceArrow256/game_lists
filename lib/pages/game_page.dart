import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:game_lists/model/game.dart';
import 'package:intl/intl.dart';

class GamePage extends StatefulWidget {
  static const routeName = '/gamePage';
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)!.settings.arguments as Game;
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(
                game.image!,
              ),
            ],
          ),
          GameInfo(
            title: null,
            info: game.description,
          ),
          GameInfo(
            title: 'Release Date',
            info: game.releaseDate != null
                ? _formatter.format(game.releaseDate!)
                : null,
          ),
          GameInfo(
            title: 'Developer(s)',
            info: game.developers.isNotEmpty
                ? game.developers.map((e) => e.name).toList().join(', ')
                : null,
          ),
          GameInfo(
            title: 'Franchise(s)',
            info: game.franchises.isNotEmpty
                ? game.franchises.map((e) => e.name).toList().join(', ')
                : null,
          ),
          GameInfo(
            title: 'Genre(s)',
            info: game.genres.isNotEmpty
                ? game.genres.map((e) => e.name).toList().join(', ')
                : null,
          ),
          GameInfo(
            title: 'Platform(s)',
            info: game.platforms.isNotEmpty
                ? game.platforms.map((e) => e.name).toList().join(', ')
                : null,
          ),
        ],
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  GameInfo({
    Key? key,
    required this.title,
    required this.info,
    this.textStyle,
  }) : super(key: key);

  final String? title;
  final String? info;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return info != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                title != null ? '${title!}: ${info!}' : info!,
                textAlign: TextAlign.justify,
                style: textStyle,
              ),
            ],
          )
        : Container();
  }
}
