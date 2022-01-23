import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/main/runApp.dart';

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

  void setData(User u) {
    if(mounted) {
      setState(() {
        if(u.isAnonymous) {
          name = u.uid;
          return;
        }
        name = u.name;
        age = u.age;
        evaluation = u.evaluation;
        country = u.country;
        profileImageUrl = u.imagesUrls['profile'];
      });
    }
  }

  void getCurrentUser() async {
    user = await Auth.getCurrentUser();
    setData(user);
  }

  void editProfile() async {
    if(user.isAnonymous) {
      await Navigator.pushNamed(context, '/login', arguments: user);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RunApp(filter: Filter())));
      return;
    }
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
      color: PersonalizedColor.black,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: editProfile,
        child: Stack(
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: (user.isAnonymous || profileImageUrl.isEmpty) ?

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

                            Text(name + ", " + age.toString(), style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),

                            Text(country, style: const TextStyle(
                                color: Colors.white
                            ),)

                          ],
                        ),


                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(evaluation.toInt().toString() + "%", style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
