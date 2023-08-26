import 'package:flutter/material.dart';
import 'package:sharebao/const.dart';

class FinanceItemPage extends StatefulWidget {
  final Map<String, dynamic> item;
  const FinanceItemPage({super.key, required this.item});

  @override
  State<FinanceItemPage> createState() => _FinanceItemPageState();
}

class _FinanceItemPageState extends State<FinanceItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Record Detail'),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
