import 'package:flutter/material.dart';
import 'package:xtream/model/messageData.dart';


class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  void openChat() {
    Navigator.of(context).pushNamed('/chat', arguments: widget.messageData.user);
  }

  void showConversationOptions() {
    print("open " + widget.messageData.user.name + " chat options");
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

                                Text(widget.messageData.user.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

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

                            Text(widget.messageData.lastMessage,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.bold))

                          ],
                        ),
                      ),
                    )



                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(widget.messageData.lastMessageDate, style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.bold))
              ),
            ],
          )
      ),
    );
  }
}
