import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return GNav(
      padding: const EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
      iconSize: 30,
      onTabChange: (value) => onTabChange!(value),
      color: Colors.grey[100],
      backgroundColor: const Color.fromARGB(255, 225, 190, 231),
      activeColor: Colors.purple,
      tabs: const [
        GButton(
          icon: Icons.home,
        ),
        GButton(
          icon: Icons.list,
        ),
        // GButton(
        //   icon: Icons.add,
        // ),
        GButton(
          icon: Icons.arrow_downward,
        ),
        GButton(
          icon: Icons.money,
        )
      ],
    );
  }
}
