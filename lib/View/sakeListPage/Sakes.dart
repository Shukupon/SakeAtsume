import 'package:flutter/material.dart';
import 'package:sakeatsume/main.dart';
import 'package:sakeatsume/Model/Sake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sakeatsume/View/registerPage/RegisterPage.dart';
import "dart:io";

class Sakes extends StatefulWidget {
  const Sakes({super.key});

  @override
  State<Sakes> createState() => _SakesState();
}

class _SakesState extends State<Sakes> {
  final _sakeLists = <Sake>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  late List<String>? totalIndex;
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    Future.value(getSharedPreference());
    loadSavedSake;

    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _sakeLists.length,
        itemBuilder: (context, index) {
          return _sakeItem(_sakeLists[index]);
        });
  }

  // TODO: 表示要素とその順番を調整
  Widget _sakeItem(Sake sake) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: Image.file(File(sake.getImageFilePath1())),
        title: Text(
          sake.getName(),
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        subtitle: Text(sake.getCreatedDate()),
        onTap: () {
          showRegisterPage(context, sake);
        },
      ),
    );
  }

  void loadSavedSake() async {
    totalIndex = prefs.getStringList('indexes');
    if (totalIndex != null) {
      totalIndex?.forEach((index) {
        List<String>? savedSakeData = prefs.getStringList(index);
        if (savedSakeData != null) _sakeLists.add(Sake(savedSakeData));
      });
    }
  }

  void showRegisterPage(BuildContext buildContext, Sake sake) {
    Navigator.push(
      buildContext,
      MaterialPageRoute(builder: (context) => RegisterPage(sake: sake)),
    );
  }

  void deleteSake(String index) {
    totalIndex?.remove(index);
    prefs.setStringList('indexes', totalIndex!);
    prefs.remove(index);
    setState(() {});
  }

  Future<void> getSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }
}
