import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sakeatsume/main.dart';
import 'package:sakeatsume/Model/Sake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sakeatsume/View/registerPage/RegisterPage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "dart:io";

class Sakes extends StatefulWidget {
  const Sakes({super.key});

  @override
  State<Sakes> createState() => _SakesState();
}

class _SakesState extends State<Sakes> {
  late List<Sake> _sakeLists;
  late List<String>? totalIndex;
  SharedPreferences? _prefs;
  final String defaultSakeFilePath = 'images/sake_grey.jpeg';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _loadSavedSake(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          // 読み込み中はローディングマークを表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _sakeLists.length,
              itemBuilder: (context, index) {
                return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.2,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _deleteSake(_sakeLists[index].getIndex());
                          },
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: _sakeItem(_sakeLists[index]));
              },
            );
          }

          return const Text('データが取得できませんでした。');
        },
      ),
    );
  }

  // TODO: 表示要素とその順番を調整
  Widget _sakeItem(Sake sake) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: sake.getImageFilePath1() != ''
            ? Image.file(File(sake.getImageFilePath1()))
            : Image.asset(defaultSakeFilePath),
        title: Text(
          sake.getName(),
          style: const TextStyle(color: Colors.black, fontSize: 25.0),
        ),
        subtitle: Text(sake.getCreatedDate()),
        trailing: Text(
          '評価：${sake.getScore()}',
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        onTap: () {
          _showRegisterPage(context, sake);
        },
      ),
    );
  }

  Future<bool> _loadSavedSake() async {
    if (_prefs == null) {
      await _getSharedPreference();
    }
    _sakeLists = <Sake>[];
    totalIndex = await Future.value(_prefs?.getStringList('indexes'));
    if (totalIndex != null) {
      totalIndex?.forEach((index) {
        List<String>? savedSakeData = _prefs?.getStringList(index);
        if (savedSakeData != null) _sakeLists.add(Sake(savedSakeData));
      });
    }
    // FutureBuilderで判定するためだけにtrueをreturnを返している
    return true;
  }

  void _showRegisterPage(BuildContext buildContext, Sake sake) async {
    await Navigator.push(
      buildContext,
      MaterialPageRoute(builder: (context) => RegisterPage(sake: sake)),
    );
    setState(() {});
  }

  void _deleteSake(String index) {
    totalIndex?.remove(index);
    _prefs?.setStringList('indexes', totalIndex!);
    _prefs?.remove(index);
    setState(() {});
  }

  Future<void> _getSharedPreference() async {
    await SharedPreferences.getInstance().then((value) => _prefs = value);
  }
}
