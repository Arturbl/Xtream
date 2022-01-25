import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xtream/controller/main/firestoreApi.dart';
import 'package:xtream/model/messageData.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/sizing.dart';

import 'messageWidget.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  final List<Widget> conversations = [];

  Widget getMessageData(Map<String, dynamic> data, String toUserUid) {
    MessageData newData = MessageData();
    newData.message = data['message'];
    newData.date = data['date'];
    newData.read = data['read'];
    newData.toUserName = data['toUserName'];
    return MessageWidget(messageData: newData);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MessageData data = MessageData();
    data.message = "Ola Xinho";
    data.date = Timestamp.now();
    data.read = false;
    data.toUserName = 'Luis';

    // ver este link para criar nova forma de guardar mensagens
    //   -> https://firebase.flutter.dev/docs/firestore/usage/#document--query-snapshots
    //   -> scroll to: Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();

    FirebaseFirestore.instance.collection('messages').doc('0bCVK2JyPZNaMq90e0roElpeVPM2').collection('to').doc('szF6dEhjLdUEd56CORYwaO2MW0n1').set(data.toMap());
    FirebaseFirestore.instance.collection('messages').doc('szF6dEhjLdUEd56CORYwaO2MW0n1').collection('to').doc('0bCVK2JyPZNaMq90e0roElpeVPM2').set(data.toMap());
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
              return const Center(
                  child: Text('Something went wrong.')
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