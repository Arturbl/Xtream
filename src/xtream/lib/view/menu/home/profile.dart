import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/sizing.dart';
import 'package:xtream/util/tuple.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.currentUser, required this.toUser}) : super(key: key);

  final User currentUser;
  final User toUser;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool showButtons = false;
  int messageButtonSize = 40;
  int donateButtonSize = 40;

  void openChat() {
    Navigator.pushNamed(context, "/chat", arguments: Tuple<User, User>(widget.currentUser, widget.toUser));
  }

  void updateShowButtonsStatus(bool value) {
    if(mounted) { setState(() { showButtons = value; }); }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Set live to full screen"),
      child: MouseRegion(
        onEnter: (PointerEnterEvent event) => updateShowButtonsStatus(true),
        onExit: (PointerExitEvent event) => updateShowButtonsStatus(false),
        cursor: SystemMouseCursors.click,
        child: Stack(
          children: <Widget>[

            Container(
              width: Sizing.getScreenWidth(context), // MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.height * 0.70,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: PersonalizedColor.black,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: widget.toUser.imagesUrls['profile'].isEmpty ?
                  const DecorationImage(
                      image: AssetImage('assets/images/profile_avatar.png'),
                      fit: BoxFit.cover
                  ) :
                  DecorationImage(
                      image: NetworkImage(widget.toUser.imagesUrls['profile']),
                      fit: BoxFit.cover
                  )
              ),
              child: showButtons ?
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        MouseRegion(
                          onEnter: (PointerEnterEvent event) => setState(() => messageButtonSize = 45),
                          onExit: (PointerExitEvent event) =>  setState(() => messageButtonSize = 40),
                          child: GestureDetector(
                            onTap: openChat,
                            child: CircleAvatar(
                              radius: messageButtonSize.toDouble(),
                              backgroundColor: Colors.black54,
                              child: const Icon(Icons.messenger),
                            ),
                          ),
                        ),


                        MouseRegion(
                          onEnter: (PointerEnterEvent event) => setState(() => donateButtonSize = 45),
                          onExit: (PointerExitEvent event) =>  setState(() => donateButtonSize = 40),
                          child: Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: CircleAvatar(
                              radius: donateButtonSize.toDouble(),
                              backgroundColor: Colors.black54,
                              child: const Icon(Icons.wallet_giftcard_sharp),
                            )
                          ),
                        ),



                      ],
                    )
                ) :
                null,
            ),

            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(5,5,5,0),
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                  ),
                ),
                width: Sizing.getScreenWidth(context), // MediaQuery.of(context).size.width * 0.50,
                margin: const EdgeInsets.all(15),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: widget.toUser.name + ", " + widget.toUser.age.toString(),
                                        style: TextStyle(
                                            fontSize: Sizing.fontSize + 2,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  )
                              ),
                            ),

                            Text(widget.toUser.country, style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Sizing.fontSize
                            ),)
                          ],
                        ),


                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(widget.toUser.evaluation.toString() + "%", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Sizing.fontSize
                          ),),
                        ),


                      ],
                    )
                ),
              ),
            ),

            const Positioned(
                top: 30,
                right: 30,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.green,
                )
            ),

          ],
        ),
      )
    );
  }
}
