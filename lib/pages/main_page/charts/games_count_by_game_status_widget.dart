import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/status.dart';
import 'package:hive/hive.dart';

class GameCountData {
  Status? status;
  int count;
  Color color;
  GameCountData({
    required this.status,
    required this.count,
    required this.color,
  });
}

class GamesCountByGameStatusWidget extends StatefulWidget {
  @override
  _GamesCountByGameStatusWidgetState createState() =>
      _GamesCountByGameStatusWidgetState();
}

class _GamesCountByGameStatusWidgetState
    extends State<GamesCountByGameStatusWidget> {
  Future<List<GameCountData>> _getGameCountByGameStatus() async {
    var gameBox = await Hive.openBox<Game>('game');
    var data = <GameCountData>[];
    data.add(
      GameCountData(
        status: null,
        count: gameBox.values.length,
        color: Color(0xff8fbcbb),
      ),
    );
    data.add(
      GameCountData(
        status: Status.playing,
        count: gameBox.values
            .where((element) => element.status == Status.playing)
            .length,
        color: Color(0xffbf616a),
      ),
    );
    data.add(
      GameCountData(
        status: Status.planning,
        count: gameBox.values
            .where((element) => element.status == Status.planning)
            .length,
        color: Color(0xffd08770),
      ),
    );
    data.add(
      GameCountData(
        status: Status.completed,
        count: gameBox.values
            .where((element) => element.status == Status.completed)
            .length,
        color: Color(0xffebcb8b),
      ),
    );
    data.add(
      GameCountData(
        status: Status.pause,
        count: gameBox.values
            .where((element) => element.status == Status.pause)
            .length,
        color: Color(0xffa3be8c),
      ),
    );
    data.add(
      GameCountData(
        status: Status.dropped,
        count: gameBox.values
            .where((element) => element.status == Status.dropped)
            .length,
        color: Color(0xffb48ead),
      ),
    );
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GameCountData>>(
        future: _getGameCountByGameStatus(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Games Count By Game Status',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    GamesCountByGameStatusChart(
                        data: data
                            .where((element) => element.status != null)
                            .toList()),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GameCountWidget(
                              name: 'All',
                              count: data[0].count,
                              color: data[0].color,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            GameCountWidget(
                              name: 'Completed',
                              count: data[3].count,
                              color: data[3].color,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GameCountWidget(
                              name: 'Playing',
                              count: data[1].count,
                              color: data[1].color,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            GameCountWidget(
                              name: 'Pause',
                              count: data[4].count,
                              color: data[4].color,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GameCountWidget(
                              name: 'Planning',
                              count: data[2].count,
                              color: data[2].color,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            GameCountWidget(
                              name: 'Dropped',
                              count: data[5].count,
                              color: data[5].color,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}

class GamesCountByGameStatusChart extends StatefulWidget {
  final List<GameCountData> data;

  const GamesCountByGameStatusChart({Key? key, required this.data})
      : super(key: key);

  @override
  _GamesCountByGameStatusChartState createState() =>
      _GamesCountByGameStatusChartState();
}

class _GamesCountByGameStatusChartState
    extends State<GamesCountByGameStatusChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 3,
      child: PieChart(
        PieChartData(centerSpaceRadius: 0, sections: showingSections()),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return widget.data
        .map((e) => PieChartSectionData(
              color: e.color,
              value: e.count.toDouble(),
              title: '${e.count}',
              radius: 100,
              titleStyle:
                  TextStyle(fontSize: 16, color: const Color(0xffffffff)),
            ))
        .toList();
  }
}

class GameCountWidget extends StatelessWidget {
  const GameCountWidget(
      {Key? key, required this.name, required this.count, required this.color})
      : super(key: key);

  final String name;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$count',
          style: TextStyle(fontSize: 32, color: color),
        ),
        Text(name, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
