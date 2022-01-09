

// this class will be used to display data from conversation in Messages()
import 'package:xtream/model/user.dart';

class MessageData {

  late User _user;
  late String _lastMessage;
  late String _lastMessageDate;
  late bool _messageRead;

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  String get lastMessage => _lastMessage;

  set lastMessage(String value) {
    _lastMessage = value;
  }

  String get lastMessageDate => _lastMessageDate;

  set lastMessageDate(String value) {
    _lastMessageDate = value;
  }

  bool get messageRead => _messageRead;

  set messageRead(bool value) {
    _messageRead = value;
  }
}