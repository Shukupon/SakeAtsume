import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sakeatsume/Model/Sake.dart';
import 'package:sakeatsume/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Sake sake;
  // 一時的に作成,後でSakeに統合
  File? imageFile;
  String defaultSakeFilePath = 'images/sake_grey.jpeg';
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext buildContext) {
    Future.value(setImage());

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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              height: 200,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getSakeImage();
                      saveSakeImagePath();
                      setState(() {});
                    },
                    child: Container(
                      child: imageFile != null
                          ? Image.file(imageFile!)
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
            ),
            Container(
              height: 80,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getSakeImage() async {
    final ImagePicker picker = ImagePicker();
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      imageFile = File(pickerFile.path);
    }
  }

  Future<void> setSakeImage() async {
    final String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      imageFile = File(imagePath);
      setState(() {});
    }
  }

  Future<void> saveSakeImagePath() async {
    if (imageFile != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', imageFile!.path);
      setState(() {});
    }
  }

  Future<void> getSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setImage() async {
    await getSharedPreference();
    final String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      imageFile = File(imagePath);
      setState(() {});
    }
  }
}

void _registerSake(BuildContext buildContext) {
  // TODO: 保存処理
  Navigator.pop(buildContext);
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getApplicationDocumentsDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
