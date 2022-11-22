import 'package:flutter/material.dart';

// SharedPreferencesで保存するために型はすべてStringとする
class Sake {
  String _index = '';
  String _name = '';
  String _createdDate = '';
  String _price = '';
  String _prefecture = ''; // 選択できるようにする
  String _brewery = '';
  String _kindsOfRice = '';
  String _alcoholDegree = '';
  String _sakeDegree = '';
  String _kind = '';
  String _polishingRatio = '';
  String _score = '';
  String _memo = '';
  String _imageFilePath1 = '';
  String _imageFilePath2 = '';

  Sake(List<String> savedData) {
    _index = savedData[0];
    _name = savedData[1];
    _createdDate = savedData[2];
    _price = savedData[3];
    _prefecture = savedData[4];
    _brewery = savedData[5];
    _kindsOfRice = savedData[6];
    _alcoholDegree = savedData[7];
    _sakeDegree = savedData[8];
    _kind = savedData[9];
    _polishingRatio = savedData[10];
    _score = savedData[11];
    _memo = savedData[12];
    _imageFilePath1 = savedData[13];
    _imageFilePath2 = savedData[14];
  }

  String getIndex() => _index;
  String getName() => _name;
  String getCreatedDate() => _createdDate;
  String getPrice() => _price;
  String getPrefecture() => _prefecture;
  String getBrewery() => _brewery;
  String getKindsOfRice() => _kindsOfRice;
  String getAlcoholDegree() => _alcoholDegree;
  String getSakeDegree() => _sakeDegree;
  String getKind() => _kind;
  String getPolishingRatio() => _polishingRatio;
  String getScore() => _score;
  String getMemo() => _memo;
  String getImageFilePath1() => _imageFilePath1;
  String getImageFilePath2() => _imageFilePath2;

  void setIndex(String index) {
    _index = index;
  }

  void setName(String name) {
    _name = name;
  }

  void setCreatedDate(String createdDate) {
    _createdDate = createdDate;
  }

  void setPrice(String price) {
    _price = price;
  }

  void setPrefecture(String prefecture) {
    _prefecture = prefecture;
  }

  void setBrewery(String brewery) {
    _brewery = brewery;
  }

  void setKindsOfRice(String kindsOfRice) {
    _kindsOfRice = kindsOfRice;
  }

  void setAlcoholDegree(String alcoholDegree) {
    _alcoholDegree = alcoholDegree;
  }

  void setSakeDegree(String sakeDegree) {
    _sakeDegree = sakeDegree;
  }

  void setKind(String kind) {
    _kind = kind;
  }

  void setPolishingRatio(String polishingRatio) {
    _polishingRatio = polishingRatio;
  }

  void setScore(String score) {
    _score = score;
  }

  void setMemo(String memo) {
    _memo = memo;
  }

  void setImageFilePath1(String imageFilePath1) {
    _imageFilePath1 = imageFilePath1;
  }

  void setImageFilePath2(String imageFilePath2) {
    _imageFilePath2 = imageFilePath2;
  }
}
