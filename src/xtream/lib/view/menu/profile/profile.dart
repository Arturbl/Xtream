import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/sizing.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin{

  User user = User();
  String name = '';
  int age = 18;
  double evaluation = 50.0;
  String country = '';
  String profileImageUrl = '';


  void getCurrentUser() async {
    user = await Auth.getCurrentUser();
    if(mounted) {
      setState(() {
        name = user.name;
        age = user.age;
        evaluation = user.evaluation;
        country = user.country;
        profileImageUrl = user.imagesUrls['profile'];
      });
    }
  }

  void editProfile() async {
    Navigator.pushNamed(context, '/editProfile', arguments: user);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: editProfile,
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
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    image: (profileImageUrl.isEmpty) ?

                      const DecorationImage(
                          image: AssetImage('assets/images/profile_avatar.png'),
                          fit: BoxFit.cover
                      ) :
                      DecorationImage(
                          image: NetworkImage(profileImageUrl),
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
                                        text: name + ", " + age.toString(),
                                        style: TextStyle(
                                            fontSize: Sizing.fontSize + 2,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  )
                                ),
                              ),



                              Text(user.country, style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizing.fontSize
                              ),)

                            ],
                          ),


                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(evaluation.toInt().toString() + "%", style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizing.fontSize + 2,
                                fontWeight: FontWeight.bold
                            ),),
                          ),


                        ],
                      )
                  ),
                ),
              ),


              const Positioned(
                top: 20,
                right: 20,
                child:  Icon(Icons.edit, color: Colors.white, size: 24,),
              )

            ],
          ),
        )
    );
  }
}