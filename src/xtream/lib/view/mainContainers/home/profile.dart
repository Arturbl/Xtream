import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Stack(
            children: <Widget>[

              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width * 0.80,
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
                    image: const DecorationImage(
                      image: AssetImage('assets/images/julia.jpg'),
                        // image: NetworkImage(
                        //     "https://cdn.vidas.pt/images/2020-10/img_975x650\$2020_10_10_19_14_32_155118.jpg"
                        // ),
                        fit: BoxFit.cover
                    )
                ),
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.80,
                  margin: const EdgeInsets.all(15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(widget.user.name + ", " + widget.user.age.toString(), style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                            ),),

                            Text(widget.user.country, style: const TextStyle(
                                color: Colors.white
                            ),)

                          ],
                        ),


                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(widget.user.evaluation.toString() + "%", style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),),
                        ),


                        // Container(
                        //   padding: const EdgeInsets.only(top: 2),
                        //   child: Row(
                        //     children: [
                        //
                        //       Text(widget.user.numOfCalls.toString() + " ", style: const TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 14,
                        //       ),),
                        //
                        //       const Icon(
                        //         Icons.call,
                        //         color: Colors.green,
                        //         size: 15,
                        //       )
                        //
                        //     ],
                        //   ),
                        // ),

                      ],
                    )
                  ),
                ),
              )

            ],
          ),


          Container(
            width: MediaQuery.of(context).size.width * 0.80,
            height: 80,
            margin: const EdgeInsets.only(right: 15, bottom: 15, left: 15, top: 25),
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                MaterialButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.messenger_rounded),
                  padding: const EdgeInsets.all(25),
                  onPressed: () {
                    print("calling " + widget.user.name);
                  },
                ),

                // MaterialButton(
                //   color: Colors.green,
                //   textColor: Colors.white,
                //   shape: const CircleBorder(),
                //   child: const Icon(Icons.call),
                //   padding: const EdgeInsets.all(25),
                //   onPressed: () {
                //     print("calling " + widget.user.name);
                //   },
                // ),


                // MaterialButton(
                //   color: PersonalizedColor.red,
                //   textColor: Colors.white,
                //   shape: const CircleBorder(),
                //   child: const Icon(Icons.info),
                //   padding: const EdgeInsets.all(17),
                //   onPressed: () {
                //     print("more info about: " + widget.user.name);
                //   },
                // ),



              ],
            )
          )

        ],
      ),
    );
  }
}
