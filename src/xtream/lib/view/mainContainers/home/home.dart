import 'package:flutter/material.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/mainContainers/home/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Widget> displayProfiles(List<String> recvNames) {
    List<Widget> profiles = [];
    for(String name in recvNames) {
      User user = User('123', name);
      user.evaluation = 96.0;
      user.numOfCalls = 26;
      user.country = "Portugal";
      user.age = 21;
      Widget profile = Profile(user: user);
      profiles.add(profile);
    }
    return profiles;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView.builder(
          physics: const PageScrollPhysics(),
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
                color: PersonalizedColor.black,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  children: displayProfiles(["Júlia Palha", "Margot Hobbie"]),
                )
            );
          },
        )
      ),
    );
  }
}