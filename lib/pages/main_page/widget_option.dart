import 'package:flutter/material.dart';

class WidgetOption {
  final TabController? tabController;
  final AppBar appBar;
  final BottomNavigationBarItem bottomNavigationBarItem;
  final FloatingActionButton? floatingActionButton;
  final Widget widget;

  WidgetOption({
    required String title,
    this.tabController,
    bool? isTabScrollable,
    List<Tab>? tabs,
    this.floatingActionButton,
    required IconData iconData,
    required this.widget,
  })   : appBar = AppBar(
          elevation: 0,
          title: Text(title),
          bottom: tabs != null
              ? TabBar(
                  controller: tabController,
                  isScrollable: isTabScrollable ?? false,
                  tabs: tabs)
              : null,
        ),
        bottomNavigationBarItem = BottomNavigationBarItem(
          icon: Icon(iconData),
          label: title,
        );
}
