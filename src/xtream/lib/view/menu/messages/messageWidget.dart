import 'package:flutter/material.dart';
import 'package:xtream/model/messageData.dart';


class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  late DateTime date;


  void initToUserData() async  {
    // User toUserObject = await FirestoreControllerApi.getUserData(widget.toUserUid);;
    if(mounted){
      setState(() {
        // toUser = toUserObject;
        date = widget.messageData.date.toDate();
      });
    }
  }

  void openChat() {
    // Navigator.of(context).pushNamed('/chat', arguments: widget.toUser);
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

                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
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

                                Text(widget.messageData.toUserName, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

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

                            Text(widget.messageData.message,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.bold))

                          ],
                        ),
                      ),
                    )



                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(date.toString().toString(), style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.bold))
              ),
            ],
          )
      ),
    );
  }
}
