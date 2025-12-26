import 'dart:async';
import 'dart:io';

import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Provider Screens (kept for future use)
import 'package:eetinal_visit/screens/provider_section/provider_pages/provider_chat_screen.dart';
import 'package:eetinal_visit/screens/provider_section/provider_pages/provider_home_screen.dart';
import 'package:eetinal_visit/screens/provider_section/provider_pages/provider_search_screen.dart';
import 'package:eetinal_visit/screens/provider_section/provider_pages/provider_account_screen.dart';
import 'package:eetinal_visit/screens/provider_section/provider_pages/provider_favourite_screen.dart';

// User Screens (ACTIVE)
import 'package:eetinal_visit/screens/user_section/user_pages/user_account_screen.dart';
import 'package:eetinal_visit/screens/user_section/user_pages/user_chat_screen.dart';
import 'package:eetinal_visit/screens/user_section/user_pages/user_favourite_screen.dart';
import 'package:eetinal_visit/screens/user_section/user_pages/user_home_screen.dart';
import 'package:eetinal_visit/screens/user_section/user_pages/user_search_screen.dart';

class MainDashboard extends StatefulWidget {
  final int initialPageIndex;

  const MainDashboard({super.key, this.initialPageIndex = 0});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  late int _currentIndex;

  // USER screens (currently used)
  late final List<Widget> _userScreens;

  // PROVIDER screens (kept for future)
  late final List<Widget> _providerScreens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPageIndex;

    _userScreens = const [
      UserHomeScreen(),
      UserSearchScreen(),
      UserChatScreen(),
      UserFavouriteScreen(),
      UserAccountScreen(),
    ];

    _providerScreens = const [
      ProviderHomeScreen(),
      ProviderSearchScreen(),
      ProviderChatScreen(),
      ProviderFavouriteScreen(),
      ProviderAccountScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentScreen = _userScreens[_currentIndex];

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: currentScreen,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: mainColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 25),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 25),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline, size: 25),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline, size: 25),
              label: "Favourite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
