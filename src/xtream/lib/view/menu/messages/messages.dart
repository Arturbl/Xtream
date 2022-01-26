import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xtream/controller/main/firestoreApi.dart';
import 'package:xtream/model/messages/messageData.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/sizing.dart';

import 'chatPreview.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  Widget getMessageData(Map<String, dynamic> data, String toUserUid) {
    MessageData newData = MessageData();
    newData.messages = data['messages'] as List<dynamic>;
    newData.read = data['read'];
    newData.date = data['date'];
    newData.toUserName = data['toUserName'];
    return ChatPreview(messageData: newData, toUserId: toUserUid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Container(
        width: Sizing.getScreenWidth(context),// MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(10, 2,10,85),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreControllerApi.loadConversations(widget.user),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if(snapshot.hasError) {
              return Center(
                  child: Text('Something went wrong, try again', style: TextStyle(fontSize: Sizing.fontSize, color: Colors.white),)
              );
            }

            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator()
              );
            }

            if(snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text('You have no conversation yet.', style: TextStyle(fontSize: Sizing.fontSize, color: Colors.white),)
              );
            }

            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                Widget messageWidget = getMessageData(data, document.id);
                return messageWidget;
              }).toList(),
            );


          },
        ),
      ),
    );
  }

}