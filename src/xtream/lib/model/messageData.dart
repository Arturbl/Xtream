

// this class will be used to display data from conversation in Messages()
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/user.dart';

class MessageData {

  late String _toUserName;
  late String _message;
  late Timestamp _date;
  late bool _read;

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'date': date,
      'read': read,
      'toUserName': toUserName
    };
  }


  String get toUserName => _toUserName;

  set toUserName(String value) {
    _toUserName = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }


  Timestamp get date => _date;

  set date(Timestamp value) {
    _date = value;
  }

  bool get read => _read;

  set read(bool value) {
    _read = value;
  }
}