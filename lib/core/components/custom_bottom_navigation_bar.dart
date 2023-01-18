import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/utils/navigate_animation_state.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';

BottomNavigationBar customBottomNavigationBar(BuildContext context, {int? currentIndex}) {
  return BottomNavigationBar(
    backgroundColor: CustomColors.OFF_WHITE,
    currentIndex: 0,
    onTap: (value) {
      if (currentIndex != null) {
        if (currentIndex == value) {
          Navigator.pop(context);
          return;
        }
      }
      Provider.of<BottomNavBarProvider>(context, listen: false).setCurrentIndex(value);
      NavigateUtils.pushAndRemoveUntil(context, page: const CustomBottomNavBar(), animationState: NavigateAnimationState.nonAnimation);
    },
    selectedItemColor: CustomColors.DARK_GREY,
    selectedLabelStyle: const TextStyle(color: CustomColors.LIGHT_BLACK),
    unselectedItemColor: CustomColors.DARK_GREY,
    unselectedLabelStyle: const TextStyle(color: CustomColors.LIGHT_BLACK),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedFontSize: 12,
    unselectedFontSize: 12,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: "Ana Sayfa",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart_rounded),
        label: "İşlemler",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long_outlined),
        label: "Raporlar",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Ayarlar",
      ),
    ],
  );
}
