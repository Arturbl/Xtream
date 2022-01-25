import 'package:flutter/material.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/view/menu/home/profile.dart';


class Home extends StatefulWidget {
  Home({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late List<Widget> profiles;


  List<Widget> displayProfiles(List<String> names) {
    List<Widget> profiles = [];
    for(String name in names) {
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
    profiles = displayProfiles(['Julia', 'Laura', 'ana', 'Larissa']);
    // print("Country: " + widget.filter.country);
    // print("age: (min)" + widget.filter.ageRange.min.toString());
    // print("age: (max)" + widget.filter.ageRange.max.toString());
    // print("gender: " + widget.filter.gender);
    // print("ethnicity: " + widget.filter.ethnicity);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // physics: const PageScrollPhysics(),
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: profiles[index]
            )
        );
      },
    );
  }
}