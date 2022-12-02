import 'package:flutter/material.dart';
import 'package:sakeatsume/View/sakeListPage/Sakes.dart';
import 'package:sakeatsume/Model/Sake.dart';
import 'package:sakeatsume/View/registerPage/RegisterPage.dart';

class SakeListPage extends StatefulWidget {
  const SakeListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SakeListPage> createState() => _SakeListPageState();
}

class _SakeListPageState extends State<SakeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('一覧')),
        actions: <Widget>[
          TextButton(
            onPressed: () => _showRegisterPage(context),
            child: const Text(
              '登録',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Sakes(),
      ),
    );
  }

  void _showRegisterPage(BuildContext buildContext) async {
    await Navigator.push(
      buildContext,
      MaterialPageRoute(
          builder: (context) => RegisterPage(sake: Sake.createEmptySake())),
    );
    setState(() {});
  }
}
