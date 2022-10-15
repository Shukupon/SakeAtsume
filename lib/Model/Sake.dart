import 'package:flutter/material.dart';

class Sake {
  String _name;
  late DateTime _createdDate;
  late int _price;
  late int _amount;
  late String _feature;
  late String _prefecture; // 後でEnumにする
  late String _brewery;
  late String _kindsOfRice;
  late int _polishingRatio;
  late int _sakeDegree;
  late int _score;
  late String _memo;

  Sake(this._name);

  String getName() {
    return this._name;
  }
}
