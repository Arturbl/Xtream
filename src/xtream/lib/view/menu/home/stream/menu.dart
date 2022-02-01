import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/sizing.dart';

class StreamMenu extends StatefulWidget {
  const StreamMenu({Key? key}) : super(key: key);

  @override
  _StreamMenuState createState() => _StreamMenuState();
}

class _StreamMenuState extends State<StreamMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
      ),
      child: Stack(
        children: [

          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
              ),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [

                      Text("20", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.people, size: 17, color: Colors.white,),
                      )

                    ],
                  ),
                ),
              )
              )
            ),

          Container(
              margin: const EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: SizedBox(
                    width: Sizing.getScreenWidth(context),
                    child: Column(
                      children: [

                        Expanded(
                          child: ListView.builder(
                              reverse: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {

                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.65,
                                      ),
                                      // width: larguraContainer,
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)
                                          )
                                      ),
                                      child: Column(
                                        children: const [

                                          Text(
                                            'Belinha: message sa sai sua9 psag 9p',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "21:06", // timeago.format(date, locale: 'en_short'),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
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
                                        focusNode: FocusNode(),
                                        // controller: _messageController,
                                        autofocus: true,
                                        minLines: 1,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            hintText: 'Write a message...',
                                            filled: true,
                                            fillColor: Colors.white70,
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
                                  mini: true,
                                  child: const Icon(Icons.send, color: Colors.white),
                                  backgroundColor: PersonalizedColor.red, //Color(0xff25D366),
                                  onPressed: () {},
                                )
                              ],
                            )
                        )


                      ],
                    )
                ),
              )
          )

        ],
      )
    );
  }
}
