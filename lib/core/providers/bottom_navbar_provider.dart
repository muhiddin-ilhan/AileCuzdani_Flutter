import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  PageController _pageController = PageController();
  PageController get pageController => _pageController;

  setCurrentIndex(int index) {
    _currentIndex = index;
    _pageController = PageController(initialPage: index);
    notifyListeners();
  }

  goPage(int index) {
    if (currentIndex == index) {
      return;
    }

    if ((currentIndex - index).abs() > 1) {
      _pageController.jumpToPage(index);
    } else {
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 150), curve: Curves.easeOut);
    }

    _currentIndex = index;
    notifyListeners();
  }

  reset() {
    setCurrentIndex(0);
  }
}
