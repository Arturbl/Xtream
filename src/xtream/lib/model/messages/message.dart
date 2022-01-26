

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {

  late String _userUid;
  late String _data;
  late Timestamp _date;


  String get userUid => _userUid;

  Message(String userUid, String data, Timestamp date) {
    this.userUid = userUid;
    this.data = data;
    this.date = date;
  }

  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'data': data,
      'date': date
    };
  }


  set userUid(String value) {
    _userUid = value;
  }

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  Timestamp get date => _date;

  set date(Timestamp value) {
    _date = value;
  }
}