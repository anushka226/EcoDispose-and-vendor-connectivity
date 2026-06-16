import 'package:flutter/material.dart';

import 'home_tab.dart';
import 'scan_tab.dart';
import 'listings_tab.dart';
import 'profile_tab.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() =>
      _UserDashboardScreenState();
}

class _UserDashboardScreenState
    extends State<UserDashboardScreen> {

  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeTab(),
    const ScanTab(),
    const ListingsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        selectedItemColor: Colors.green,

        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Scan",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Listings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}