import 'package:flutter/material.dart';
import 'package:sharebao/pages/home_page.dart';
import 'package:sharebao/pages/list_page.dart';
import 'package:sharebao/pages/activity_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/homePage': (context) => HomePage(),
        '/listPage': (context) => ListPage(),
        '/activityPage': (context) => ActivityPage(),
      },
    );
  }
}
