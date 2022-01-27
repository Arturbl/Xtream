import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/controller/main/firestoreApi.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/tuple.dart';
import 'package:xtream/view/menu/home/profile.dart';


class Home extends StatefulWidget {
  const Home({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ScrollController listViewController = ScrollController();
  ScrollPhysics scrollPhysics = const BouncingScrollPhysics();

  late User currentUser;
  List<Widget> profiles = [];
  List<String> currentUsersUids = [];

  int profilesIndex = 0;
  bool showLoadingIcon = false;

  void updateScrollPhysics(ScrollPhysics physics) {
    if(mounted) { setState(() => scrollPhysics = physics );}
  }

  void updateLoadingIconStatus(bool value) {
    if(mounted) { setState(() => showLoadingIcon = value );}
  }


  Future<void> loadNewData() async  {
    updateLoadingIconStatus(true);
    await FirestoreControllerApi.loadRandomProfiles(currentUsersUids).then((List<User> users) {
      for(User user in users) {
        if(mounted) {
          setState(() {
            profiles.add( Profile(user: user) );
            currentUsersUids.add(user.uid);
          });
        }
      }
      updateScrollPhysics(const BouncingScrollPhysics());
      updateLoadingIconStatus(false);
    });
  }

  // update profiles index and reload new data if needed.
  void updateData() {
    listViewController.addListener(() async {
      double currentExtent = listViewController.position.extentBefore;
      double maxExtent = listViewController.position.maxScrollExtent;
      ScrollDirection direction = listViewController.position.userScrollDirection;
      if(direction == ScrollDirection.reverse &&  currentExtent == maxExtent) {
        updateScrollPhysics(const NeverScrollableScrollPhysics());
        await loadNewData();
      }
    });
  }

  void initUserData() async {
    await Auth.getCurrentUser().then((User user) async {
      currentUsersUids.add(user.uid);
      currentUser = user;
      loadNewData();
      updateData();
    });
  }

  @override
  void initState() {
    super.initState();
    updateLoadingIconStatus(true);
    initUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PersonalizedColor.black1,
      body: ListView.builder(
        physics: scrollPhysics,
        itemCount: profiles.length,
        scrollDirection: Axis.vertical,
        controller: listViewController,
        itemBuilder: (context, index) {

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
      ),
      bottomNavigationBar: showLoadingIcon ? Container(
        height: 30,
        color: Colors.transparent,
        child: const Center(
          child: SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(),
          )
        )
      ) :
      null
    );
  }
}