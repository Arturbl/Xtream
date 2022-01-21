import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';

class Profile extends StatefulWidget {
  // const Profile({Key? key, required this.user}) : super(key: key);
  const Profile({Key? key}) : super(key: key);

  // final User? user;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PersonalizedColor.black,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          User user = User();
          Navigator.pushNamed(context, '/editProfile', arguments: user);
        },
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
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: const DecorationImage(
                      image: AssetImage('assets/images/futebol.jpeg'),
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
                          children: const [

                            Text("Artur" + ", " + "20", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),

                            Text("Brasil", style: TextStyle(
                                color: Colors.white
                            ),)

                          ],
                        ),


                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 2),
                          child: Text("100" + "%", style: const TextStyle(
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
