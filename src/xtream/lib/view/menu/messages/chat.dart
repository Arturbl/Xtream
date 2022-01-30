
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xtream/controller/main/firestoreApi.dart';
import 'package:xtream/model/messages/message.dart';
import 'package:xtream/model/messages/messageData.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/chatUtils.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/sizing.dart';
import 'package:xtream/util/tuple.dart';
import 'package:timeago/timeago.dart' as timeago;

class Chat extends StatefulWidget {

  Chat(this.tuple);

  final Tuple<User, User> tuple;

  @override
  _ChatState createState() => _ChatState();
}


class _ChatState extends State<Chat> {

  FocusNode focusNode = FocusNode();

  final TextEditingController _messageController = TextEditingController();
  late final User currentUser;
  late final User toUser;
  final MessageData messageData = MessageData();


  void sendMessage() {
    String message = _messageController.text;
    if(message.trim().isNotEmpty) {
      messageData.date = Timestamp.fromDate(DateTime.now());
      messageData.read = false;
      messageData.toUserName = toUser.name;
      messageData.toUserUid = toUser.uid;
      Message msg = Message(
          currentUser.uid,
          message,
          Timestamp.fromDate(DateTime.now())
      );
      messageData.addMessage(msg);
      FirestoreControllerApi.sendMessage(currentUser.uid, toUser.uid, messageData);
      _messageController.clear();
      focusNode.requestFocus();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = widget.tuple.x;
    toUser = widget.tuple.y;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: PersonalizedColor.black,),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          backgroundColor: PersonalizedColor.red,
          title: Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  backgroundImage: toUser.imagesUrls['profile'].isNotEmpty ?
                  NetworkImage(toUser.imagesUrls['profile']) :
                  null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [

                    Text(
                      toUser.name,
                      style: TextStyle(
                          color: PersonalizedColor.black
                      ),
                    ),


                    const Text("online now", style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12
                    ),)

                  ],
                ),
              )
            ],
          ),
          actions: [

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: IconButton(
                tooltip: "Video call ${toUser.name}",
                icon: const Icon(Icons.videocam, color: Colors.black),
                onPressed: () {

                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: IconButton(
                tooltip: "Voice ${toUser.name}",
                icon: const Icon(Icons.call, color: Colors.black),
                onPressed: () {

                },
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: IconButton(
                tooltip: "Gift ${toUser.name}",
                icon: const Icon(Icons.wallet_giftcard_sharp, color: Colors.black),
                onPressed: () {

                },
              ),
            )

          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          // color: PersonalizedColor.black,
            decoration: BoxDecoration(
                color: toUser.imagesUrls['profile'].isEmpty ? PersonalizedColor.black : null,
                image: toUser.imagesUrls['profile'].isEmpty ?
                null :
                DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                  image: NetworkImage(toUser.imagesUrls['profile']),
                  fit: BoxFit.cover
                )
            ),
          child: Center(
            child: SafeArea(
              child: SizedBox(
                  width: Sizing.getScreenWidth(context),
                  child: Column(
                    children: [

                      Expanded(
                        child: StreamBuilder(
                          stream: FirestoreControllerApi.loadChatMessages(currentUser.uid, toUser.uid),
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
                                  child: Text('Start a conversation with ${toUser.name}.', style: TextStyle(fontSize: Sizing.fontSize, color: Colors.white),)
                              );
                            }


                            Map<String, dynamic> response = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                            messageData.fromMapToMessageData(response);


                            return ListView.builder(
                                reverse: true,
                                itemCount: messageData.messages.length,
                                itemBuilder: (context, index) {

                                  Map<String, dynamic> message = messageData.messages[index];
                                  String data = message['data'];
                                  DateTime date = message['date'].toDate();
                                  String userId = message['userUid'];


                                  //Define colors and alignments
                                  Alignment alignment = userId == currentUser.uid ? Alignment.centerRight : Alignment.centerLeft;
                                  Color messageColor = userId == currentUser.uid ?  Colors.white : Colors.grey;
                                  Color textColor = userId == currentUser.uid ?  Colors.black : Colors.white;
                                  Color dateColor = userId == currentUser.uid ?  Colors.grey : Colors.white54;

                                  return Align(
                                    alignment: alignment,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: Sizing.getScreenWidth(context) * 0.65, //MediaQuery.of(context).size.width * 0.65
                                        ),
                                        // width: larguraContainer,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: messageColor,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(8)
                                            )
                                        ),
                                        child: Column(
                                          children: [

                                            Text(
                                              data,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: textColor
                                              ),
                                            ),

                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                timeago.format(date, locale: 'en_short'),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: dateColor
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });

                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxHeight: 300.0
                                  ),
                                  child: TextField(
                                    focusNode: focusNode,
                                    controller: _messageController,
                                    autofocus: true,
                                    minLines: 1,
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                        hintText: 'Write a message...',
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: IconButton(
                                          icon: Icon(Icons.attach_file, color: PersonalizedColor.red,),
                                          onPressed: () {

                                          },
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30)
                                        )
                                    ),
                                  ),
                                )
                            ),
                            FloatingActionButton(
                              child: const Icon(Icons.send, color: Colors.white),
                              backgroundColor: PersonalizedColor.red, //Color(0xff25D366),
                              onPressed: sendMessage,
                            )
                          ],
                        )
                      )


                    ],
                  )
              ),
            )
          )
        ),
    );
  }
}
