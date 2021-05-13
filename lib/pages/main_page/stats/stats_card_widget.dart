import 'package:flutter/material.dart';

class StatElementWidget extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatElementWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        height: 64 + 12,
        width: 64 + 64 - 12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 32, color: color),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class StatsCardWidget extends StatefulWidget {
  final String title;
  final Widget? child;
  final List<Widget>? children;

  const StatsCardWidget({
    Key? key,
    required this.title,
    this.child,
    this.children,
  }) : super(key: key);

  @override
  _StatsCardWidgetState createState() => _StatsCardWidgetState();
}

class _StatsCardWidgetState extends State<StatsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            widget.child != null ? SizedBox(height: 8) : Container(),
            widget.child != null ? widget.child! : Container(),
            widget.children != null ? SizedBox(height: 8) : Container(),
            widget.children != null
                ? Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: widget.children!,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
