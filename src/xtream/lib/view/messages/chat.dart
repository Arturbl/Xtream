
import 'package:flutter/material.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';

class Chat extends StatefulWidget {

  final User user;

  Chat(this.user);

  @override
  _ChatState createState() => _ChatState();
}


class _ChatState extends State<Chat> {

  TextEditingController _controllerMensagem = new TextEditingController();

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
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [

                    Text(widget.user.name, style: TextStyle(
                        color: PersonalizedColor.black
                    ),),

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
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.videocam, color: Colors.black),
                onPressed: () {

                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: IconButton(
                icon: const Icon(Icons.call, color: Colors.black),
                onPressed: () {

                },
              ),
            )

          ],
        ),
        body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage('assets/images/eu.jpeg'),
                  //     fit: BoxFit.cover
                  // )
                color: PersonalizedColor.black
              ),
              padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: Column(
                children: [

                  Expanded(
                  child: ListView.builder(
                  itemCount: 2,
                      itemBuilder: (context, indice) {

                        //Define cores e alinhamentos
                        Alignment alinhamento = Alignment.centerRight;

                        return Align(
                          alignment: alinhamento,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.65
                              ),
                              // width: larguraContainer,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8)
                                  )
                              ),
                              child: Column(
                                children: [

                                  Text(
                                    "Hello, " + widget.user.name +
                                        "AADASASAS AHSA I" + widget.user.name,
                                    style: TextStyle(fontSize: 16),
                                  ),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: const Text(
                                      "21:06",
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  )



                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  ),

                  Row(
                    children: [
                      Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxHeight: 300.0
                            ),
                            child: TextField(
                              controller: _controllerMensagem,
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
                        mini: true,
                        onPressed: (){

                        },
                      )
                    ],
                  )


                ],
              )
          ),
        )
    );
  }
}
