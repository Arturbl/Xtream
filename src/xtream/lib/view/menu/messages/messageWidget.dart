import 'package:flutter/material.dart';
import 'package:xtream/controller/main/firestoreApi.dart';
import 'package:xtream/model/messages/messageData.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';


class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key, required this.messageData, required this.toUserId}) : super(key: key);

  final MessageData messageData;
  final String toUserId;

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  DateTime date = DateTime.now();
  String profileImageUrl = '';


  void initToUserData() {
    FirestoreControllerApi.getUserData(widget.toUserId).then((User user){
      if(mounted){
        setState(() {
          date = widget.messageData.messages.first['date'].toDate();
          profileImageUrl = user.imagesUrls['profile'];
        });
      }
    });
  }

  void openChat() async {
    User toUser = await FirestoreControllerApi.getUserData(widget.toUserId);
    Navigator.pushNamed(context, "/chat", arguments: toUser);
  }

  void showConversationOptions() {
    // print("open " + widget.toUser.name + " chat options");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initToUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: showConversationOptions,
      onTap: openChat,
      child: Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white70
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [

                    CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.black,
                        child: profileImageUrl.isEmpty ?
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/profile_avatar.png'),
                            radius: 29,
                          ) :
                        CircleAvatar(
                            backgroundImage:  NetworkImage(profileImageUrl) ,
                            radius: 29,
                          )
                    ),

                    const SizedBox(width: 16,),

                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Row(
                              children: [

                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: widget.messageData.toUserName,
                                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: PersonalizedColor.black)),
                                  ),
                                ),


                                const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.green,
                                  ),
                                )

                              ],
                            ),
                            const SizedBox(height: 10,),

                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: widget.messageData.messages.first['data'],
                                    style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ),
                            )



                          ],
                        ),
                      ),
                    )



                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(timeago.format(date, locale: 'en_short'), style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.bold))
              ),
            ],
          )
      ),
    );
  }
}
