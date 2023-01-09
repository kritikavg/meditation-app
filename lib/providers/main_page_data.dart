import 'package:fit_memoir/screens/settings_screen.dart';
import 'package:fit_memoir/screens/today_screen.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class BottomNavItemData {
  String title;
  String image;
  BottomNavItemData({
    required this.title,
    required this.image,
  });
}

class MainPageData extends ChangeNotifier {
  int currentIndex = 1;
  List<Widget> _allPages = [
    TodayScreen(),
    HomePage(),
    SettingsScreen(),
  ];
  List<BottomNavItemData> bottomItemData = [
    BottomNavItemData(
      title: "Today",
      image: "assets/icons/calendar.svg",
    ),
    BottomNavItemData(
      title: "All Exercises",
      image: "assets/icons/gym.svg",
    ),
    BottomNavItemData(
      title: "Settings",
      image: "assets/icons/Settings.svg",
    ),
  ];
  Widget currentPage = HomePage();

  MainPageData() {
    currentPage = _allPages[1];
  }

  void changeCurrentPage(int idx) {
    currentIndex = idx;
    currentPage = _allPages[currentIndex];
    notifyListeners();
  }
}
