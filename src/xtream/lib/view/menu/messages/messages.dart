import 'package:flutter/material.dart';
import 'package:xtream/model/messageData.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/sizing.dart';

import 'messageWidget.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  List<Widget> getMessages() {
    List<String> names = ["Julia Palha", "Margot Robbie", "Gabi"];
    List<Widget> widgets = [];
    for(String name in names) {
      MessageData data = MessageData();
      data.user = User();
      data.lastMessage = "me: Hello $name";
      data.lastMessageDate = "1h";
      data.messageRead = true;
      widgets.add( MessageWidget(messageData: data) );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Container(
        width: Sizing.getScreenWidth(context),// MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(10, 2,10,85),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: getMessages(),
        ),
      ),
    );
  }
}