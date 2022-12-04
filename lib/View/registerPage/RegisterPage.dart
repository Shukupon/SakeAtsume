import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sakeatsume/Model/Sake.dart';
import 'package:sakeatsume/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  final Sake sake;

  const RegisterPage({super.key, required this.sake});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Sake sake;
  final String defaultSakeFilePath = 'images/sake_grey.jpeg';
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getSharedPreference();

    // 受け取ったsakeを格納
    sake = widget.sake;
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Center(child: Text('登録')),
        actions: <Widget>[
          TextButton(
            onPressed: () => _registerSake(context),
            child: const Text(
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getSakeImage1(sake);
                    },
                    child: Container(
                      child: sake.getImageFilePath1() != ''
                          ? Image.file(File(sake.getImageFilePath1()))
                          : Image.asset(defaultSakeFilePath),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getSakeImage2(sake);
                    },
                    child: Container(
                      child: sake.getImageFilePath2() != ''
                          ? Image.file(File(sake.getImageFilePath2()))
                          : Image.asset(defaultSakeFilePath),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text('評価',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButton(
                        value: sake.getScore(),
                        items: const [
                          DropdownMenuItem(
                            value: '',
                            child: Text(''),
                          ),
                          DropdownMenuItem(
                            value: '1',
                            child: Text('1'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('2'),
                          ),
                          DropdownMenuItem(
                            value: '3',
                            child: Text('3'),
                          ),
                          DropdownMenuItem(
                            value: '4',
                            child: Text('4'),
                          ),
                          DropdownMenuItem(
                            value: '5',
                            child: Text('5'),
                          )
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            sake.setScore(value!);
                          });
                        },
                      ),
                    ),
                  ]),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller: TextEditingController(text: sake.getName()),
                      decoration: const InputDecoration(labelText: '名前'),
                      onChanged: (value) => {sake.setName(value)},
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller:
                          TextEditingController(text: sake.getCreatedDate()),
                      decoration: const InputDecoration(
                        labelText: '登録日',
                      ),
                      onChanged: (value) => {sake.setCreatedDate(value)},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller: TextEditingController(text: sake.getPrice()),
                      decoration: const InputDecoration(labelText: '価格'),
                      onChanged: (value) => {sake.setPrice(value)},
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller:
                          TextEditingController(text: sake.getPrefecture()),
                      decoration: const InputDecoration(labelText: '生産県'),
                      onChanged: (value) => {sake.setPrefecture(value)},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller:
                          TextEditingController(text: sake.getBrewery()),
                      decoration: const InputDecoration(labelText: '酒蔵'),
                      onChanged: (value) => {sake.setBrewery(value)},
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller:
                          TextEditingController(text: sake.getKindsOfRice()),
                      decoration: const InputDecoration(labelText: '酒米'),
                      onChanged: (value) => {sake.setKindsOfRice(value)},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller:
                          TextEditingController(text: sake.getAlcoholDegree()),
                      decoration: const InputDecoration(labelText: 'アルコール数'),
                      onChanged: (value) => {sake.setAlcoholDegree(value)},
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller:
                          TextEditingController(text: sake.getSakeDegree()),
                      decoration: const InputDecoration(labelText: '日本酒度'),
                      onChanged: (value) => {sake.setSakeDegree(value)},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller: TextEditingController(text: sake.getName()),
                      decoration: const InputDecoration(labelText: '種類'),
                      onChanged: (value) => {sake.setName(value)},
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: TextField(
                      enabled: true,
                      style: const TextStyle(fontSize: 20.0),
                      controller:
                          TextEditingController(text: sake.getCreatedDate()),
                      decoration: const InputDecoration(labelText: '精米歩合'),
                      onChanged: (value) => {sake.setCreatedDate(value)},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 160.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                enabled: true,
                style: const TextStyle(fontSize: 20.0),
                maxLines: null,
                controller: TextEditingController(text: sake.getMemo()),
                decoration: const InputDecoration(
                  labelText: 'メモ',
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                ),
                onChanged: (value) => {sake.setMemo(value)},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getSakeImage1(Sake sake) async {
    final ImagePicker picker = ImagePicker();
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      sake.setImageFilePath1(pickerFile.path);
      setState(() {});
    }
  }

  Future<void> getSakeImage2(Sake sake) async {
    final ImagePicker picker = ImagePicker();
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      sake.setImageFilePath2(pickerFile.path);
      setState(() {});
    }
  }

  Future<void> getSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _registerSake(BuildContext buildContext) {
    // TODO: 保存処理
    // 新規登録の場合にインデックスを採番
    List<String>? totalIndex = prefs.getStringList('indexes');
    if (sake.getIndex() == '') {
      if (totalIndex == null) {
        totalIndex = <String>['0'];
        sake.setIndex('0');
      } else {
        String nextIndex = (int.parse(totalIndex.last) + 1).toString();
        sake.setIndex(nextIndex);
        totalIndex.add(nextIndex);
      }
      prefs.setStringList('indexes', totalIndex);
    }
    prefs.setStringList(sake.getIndex(), sake.toStringList());

    Navigator.pop(buildContext);
  }
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getApplicationDocumentsDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
