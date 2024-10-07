import 'package:flutter/cupertino.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  CupertinoTabController? _tabController;

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  // Method to set the tab controller
  void setTabController(CupertinoTabController tabController) {
    _tabController = tabController;
  }

  // Method to navigate to a page inside a specific tab
  void navigateToPageInTab(BuildContext context, int tabIndex, Widget page) {
    if (_tabController != null) {
      // Switch to the desired tab
      _tabController!.index = tabIndex;

      // Push the new page using the context of the current tab
      Navigator.of(context).push(CupertinoPageRoute(builder: (context) => page));
    }
  }
}
