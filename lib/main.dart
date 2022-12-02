import 'package:flutter/material.dart';
import 'package:sakeatsume/Model/Sake.dart';
import 'package:sakeatsume/View/sakeListPage/SakeListPage.dart';
import 'package:sakeatsume/View/sakeListPage/Sakes.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '日本酒記録アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SakeListPage(title: '一覧'),
    );
  }
}
