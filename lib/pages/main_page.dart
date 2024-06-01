import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensor_tez/constants/colors.dart';
import 'package:sensor_tez/pages/home_page.dart';
import 'package:sensor_tez/pages/notification_page.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const NotificationPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: TW3Colors.gray.shade100),
        child: pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildBottomBar() {
    return FlashyTabBar(
      items: [
        FlashyTabBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: TW3Colors.gray.shade400,
            ),
            title: const Text("Ana Sayfa"),
            activeColor: CustomColors.primary),
        FlashyTabBarItem(
            icon: SvgPicture.asset(
              'assets/icons/notification.svg',
              color: TW3Colors.gray.shade400,
            ),
            title: const Text("Bildirimlerim"),
            activeColor: CustomColors.primary),
      ],
      selectedIndex: selectedIndex,
      showElevation: true,
      onItemSelected: onItemTapped,
      animationDuration: const Duration(milliseconds: 200),
    );
  }
}
