import 'package:flutter/material.dart';
import 'package:sharebao/const.dart';

// it's a separate scaffold, no need to show bottom nav bar

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Settings Page'),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
