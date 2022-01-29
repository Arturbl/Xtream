

// this class will be used to display data from conversation in Messages()
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/messages/message.dart';

class MessageData {

  String _toUserName = '';
  String _toUserUid = '';
  List<dynamic> _messages = []; // List<<Map<String, String>>>
  Timestamp _date = Timestamp.now(); // keep record of the last message date
  bool _read = false;

  Map<String, dynamic> toMap() {
    return {
      'messages': _messages,
      'date': date,
      'read': read,
      'toUserName': toUserName,
      'toUserUid': toUserUid
    };
  }

  MessageData fromMapToMessageData(Map<String, dynamic> map) {
    read = map['read'];
    date = map['date'];
    toUserName = map['toUserName'];
    messages = map['messages'];
    return this;
  }


  Message fromMapToMessageObj(dynamic message) {
    return Message(message['userUid']!, message['data']!, message['date']!);
  }


  List<dynamic> get messages => _messages; //.reversed.toList();

  set messages(List<dynamic> value) {
    _messages = value;
  }

  void addMessage(Message message){
    if(_messages.length < 11) { // save only 20 messages for chat
      _messages.insert(0, message.toMap());
      return;
    }
    _messages.insert(0, message.toMap());
    _messages.removeLast();
  }

  String get toUserName => _toUserName;

  set toUserName(String value) {
    _toUserName = value;
  }


  String get toUserUid => _toUserUid;

  set toUserUid(String value) {
    _toUserUid = value;
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