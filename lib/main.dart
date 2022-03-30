import 'package:flutter/material.dart';
import 'package:listtodo/Home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Home(),
    );
  }
}
