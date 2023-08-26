import 'package:flutter/material.dart';
import 'package:sharebao/const.dart';
import 'package:sharebao/data/category_data.dart';
import 'package:sharebao/data/joint_goal_data.dart';
import 'package:sharebao/pages/activity_page.dart';
import 'package:sharebao/pages/goal_page.dart';
import 'package:sharebao/pages/list_page.dart';
import 'package:sharebao/pages/overview_page.dart';
import 'package:sharebao/components/bottom_nav_bar.dart';

import 'add_item_page.dart';

// Houses navigation bar, handles page navigation after login
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // navigate bottom bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages
  final List<Widget> _pages = [
    // overview page
    OverviewPage(),
    // list page
    ListPage(),
    // activity page
    ActivityPage(),
    // goal page
    GoalPage()
  ];

  // Load necessary data
  @override
  void initState() {
    getCategories();
    getBudgetGoal();
    getProjectGoal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // Remove: button for testing add function
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // go to Add page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemPage(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 187, 110, 201),
        child: Text(
          '+',
          style: TextStyle(fontSize: 30),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: Colors.black.withOpacity(.16),
            )
          ],
        ),
        child: MyBottomNavBar(
          onTabChange: (index) => navigateBottomBar(index),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
