import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/sizing.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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

                        Text(widget.user.name + ", " + widget.user.age.toString(), style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizing.fontSize + 2,
                          color: Colors.white,
                        ),),

                        Text(widget.user.country, style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizing.fontSize
                        ),)
                      ],
                    ),


                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(widget.user.evaluation.toString() + "%", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizing.fontSize
                      ),),
                    ),


                  ],
                )
            ),
          ),
        )

      ],
    );
  }
}
