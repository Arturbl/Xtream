import 'package:flutter/material.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/menu/profile.dart';


class Home extends StatefulWidget {
  Home({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late List<Widget> profiles;


  List<Widget> displayProfiles(List<String> recvNames) {
    List<Widget> profiles = [];
    for(String name in recvNames) {
      User user = User();
      user.name = name;
      user.evaluation = 96.0;
      user.country = "Portugal";
      user.age = 21;
      Widget profile = Profile(user: user);
      profiles.add(profile);
    }
    return profiles;
  }

  @override
  void initState() {
    super.initState();
    profiles = displayProfiles(["Júlia Palha", "Margot Hobbie", "Jennifer Lawrence", "Gabi"]);
    // print("Country: " + widget.filter.country);
    // print("age: (min)" + widget.filter.ageRange.min.toString());
    // print("age: (max)" + widget.filter.ageRange.max.toString());
    // print("gender: " + widget.filter.gender);
    // print("ethnicity: " + widget.filter.ethnicity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: PersonalizedColor.black,
        child: ListView.builder(
          physics: const PageScrollPhysics(),
          // physics: const BouncingScrollPhysics(),
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: profiles[index]
                )
            );
          },
        )
    );
  }
}