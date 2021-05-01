import 'package:flutter/material.dart';

class StatisticsWidgetOption extends StatefulWidget {
  StatisticsWidgetOption({Key? key, this.tabController}) : super(key: key);

  @override
  _StatisticsWidgetOptionState createState() => _StatisticsWidgetOptionState();

  final TabController? tabController;
}

class _StatisticsWidgetOptionState extends State<StatisticsWidgetOption> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        Icon(Icons.directions_car),
        Icon(Icons.directions_transit),
      ],
    );
  }
}
