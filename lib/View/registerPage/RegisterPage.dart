import 'package:flutter/material.dart';
import 'package:sakeatsume/Model/Sake.dart';
import 'package:sakeatsume/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Sake sake;

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('登録')),
        actions: <Widget>[
          TextButton(
            onPressed: () => _registerSake(context),
            child: Text(
              '保存',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[],
              ),
              height: 200,
            ),
            Container(
              height: 80,
              color: Colors.red,
            ),
            Container(
              height: 80,
            ),
            Container(
              height: 80,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

void _registerSake(BuildContext buildContext) {
  // TODO: 保存処理
  Navigator.pop(buildContext);
}
