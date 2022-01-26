

// this class will be used to display data from conversation in Messages()
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/messages/message.dart';

class MessageData {

  late String _toUserName;
  late List<dynamic> _messages; // List<<Map<String, String>>>
  late Timestamp _date; // keep record of the last message date
  late bool _read;

  Map<String, dynamic> toMap() {
    return {
      'messages': _messages,
      'date': date,
      'read': read,
      'toUserName': toUserName
    };
  }

  Message fromMapToMessageObj(dynamic message) {
    return Message(message['userUid']!, message['data']!, message['date']!);
  }


  List<dynamic> get messages => _messages;

  set messages(List<dynamic> value) {
    _messages = value;
  }

  void addMessage(Message message){
    if(_messages.length < 21) { // save only 20 messages for chat
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


  Timestamp get date => _date;

  set date(Timestamp value) {
    _date = value;
  }

  bool get read => _read;

  set read(bool value) {
    _read = value;
  }
}