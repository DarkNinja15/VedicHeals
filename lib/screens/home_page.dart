import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:vedic_heals/constants/global_variables.dart';
import 'package:vedic_heals/provider/user_provider.dart';
import 'package:vedic_heals/screens/profile_page.dart';
import 'explore_page.dart';
import 'landing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNumber = 0;
  @override
  void initState() {
    pageNumber = 0;
    addData();
    super.initState();
  }

  void addData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageNumber == 0
          ? const LandingPage()
          : pageNumber == 1
              ? const Explore()
              : const ProfilePage(),
      bottomNavigationBar: Container(
        color: bottomNavBarColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          child: GNav(
              onTabChange: (index) {
                setState(() {
                  pageNumber = index;
                });
                if (kDebugMode) {
                  print(pageNumber);
                }
              },
              activeColor: Colors.black,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              color: Colors.black87,
              tabBackgroundColor: Colors.grey.shade300,
              gap: 8,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.explore,
                  text: 'Explore',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ]),
        ),
      ),
    );
  }
}
