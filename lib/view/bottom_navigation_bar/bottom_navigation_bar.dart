import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/view/home/home_view.dart';
import 'package:aile_cuzdani/view/settings/settings_view.dart';
import 'package:aile_cuzdani/view/transactions/transactions_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../reports/reports_view.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (_, provider, __) => Scaffold(
        backgroundColor: CustomColors.OFF_WHITE,
        bottomNavigationBar: bottomNavBar(provider),
        body: SizedBox.expand(
          child: PageView(
            controller: provider.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              TransactionsView(),
              const ReportsView(),
              const SettingsView(),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar bottomNavBar(BottomNavBarProvider provider) {
    return BottomNavigationBar(
      backgroundColor: CustomColors.OFF_WHITE,
      currentIndex: provider.currentIndex,
      onTap: (value) {
        provider.goPage(value);
      },
      selectedItemColor: CustomColors.GREEN,
      selectedLabelStyle: const TextStyle(color: CustomColors.LIGHT_BLACK),
      unselectedItemColor: CustomColors.DARK_GREY,
      unselectedLabelStyle: const TextStyle(color: CustomColors.LIGHT_BLACK),
      showSelectedLabels: true,
      showUnselectedLabels: true,
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
}
