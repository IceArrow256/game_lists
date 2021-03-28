import 'package:flutter/material.dart';

class WidgetOption {
  final String title;
  final String label;
  final Widget widget;
  final Icon icon;

  WidgetOption(this.label,
      {required this.title, required this.widget, required IconData iconData})
      : icon = Icon(iconData);
}
