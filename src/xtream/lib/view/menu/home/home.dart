import 'package:flutter/material.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/controller/main/firestoreApi.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/view/menu/home/profile.dart';


class Home extends StatefulWidget {
  const Home({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late List<Widget> profiles = [];
  int profilesIndex = 0;


  void loadProfiles() async  {
    User currentUser = await Auth.getCurrentUser();
    List<User> users = await FirestoreControllerApi.loadProfiles(currentUser);
    for(User user in users) {
      if(mounted) {
        setState(() => profiles.add( Profile(user: user) ));
      }
    }
  }

  // update profiles index and reload new data if needed.
  void updateData(int index) {
    if(mounted && index < profiles.length - 1) {
      setState(() => profilesIndex = index);
      return;
    }

  }

  @override
  void initState() {
    super.initState();
    loadProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // physics: const PageScrollPhysics(),
      physics: const BouncingScrollPhysics(),
      itemCount: profiles.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {

        updateData(index);

        if(profiles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

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