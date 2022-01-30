import 'package:flutter/material.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart' as userClass;
import 'package:xtream/util/colors.dart';
import 'dart:html' as html;

import 'menu/home/filterWidget.dart';
import 'menu/home/home.dart';
import 'menu/messages/messages.dart';
import 'menu/profile/profile.dart';

class RunApp extends StatefulWidget {
  const RunApp({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _RunAppState createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {

  late userClass.User? currentUser;
  bool isCurrentUserInitialized = false;

  late Widget _container;
  late Home home;


  void setContainer(Widget newContainer) {
    if(mounted) { setState(() => _container = newContainer);}
  }

  Future<void> initUserSession() async {
    dynamic user = await Auth.getCurrentUser();
    print("Current user: ${user.name} - UID: ${user.uid}");
    if(user == null) {
        await Navigator.pushNamed(context, '/login');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RunApp(filter: Filter())));
        return;
    }
    // print('anonymous: ' + user.isAnonymous.toString());
    currentUser = user;
    setState(() => isCurrentUserInitialized = true);
  }



  void addWindowListener() {
    html.window.onBeforeUnload.listen((event) async {
      await Auth.signOut();
      print("\nClosed session for ${currentUser!.name}");
    });
  }

  @override
  void initState() {
    super.initState();
    initUserSession();
    home = Home(filter: widget.filter);
    _container = home;
    addWindowListener();
  }


  Future showModal(Widget widget) async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        builder: (context) {
          return widget;
        }
    );
  }

  Widget setFloatingActionButton(String widgetType) {
    switch(widgetType) {
      case "Home":
        return Builder(
          builder: (context) => Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: FloatingActionButton.extended(
                elevation: 10,
                backgroundColor: PersonalizedColor.black1,
                icon: const Icon(Icons.menu, size: 22),
                label: const Text("Filters"),
                onPressed: () async {
                  await showModal(FilterWidget(filter: widget.filter));
                },
              )
          ),
        );
      case "Profile":
        return Builder(
          builder: (context) => Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: FloatingActionButton.extended(
                  elevation: 10,
                  backgroundColor: PersonalizedColor.black1,
                  label: const Text("Settings"), // Filter
                  icon:  const Icon(Icons.settings, size: 22),
                  onPressed: () =>  Navigator.of(context).pushNamed('/settings')
              )
          ),
        );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isCurrentUserInitialized ?
          AppBar(
            backgroundColor: PersonalizedColor.red,
            automaticallyImplyLeading: false,
            title: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  IconButton(
                    icon: Icon(Icons.home, color: PersonalizedColor.black),
                    tooltip: "Home",
                    onPressed:() => setContainer(home),
                  ),


                  IconButton(
                    icon: Icon(Icons.messenger_rounded, color: PersonalizedColor.black,),
                    tooltip: "Messages",
                    onPressed:() => setContainer(Messages(user: currentUser!)),
                  ),

                  IconButton(
                    icon: Icon(Icons.person, color: PersonalizedColor.black,),
                    tooltip: "My Profile",
                    onPressed:() => setContainer(Profile()),
                  ),

                ],
              ),
            ),
          ) :
          null,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: PersonalizedColor.black,
            child: Center(
              child: _container
            )
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: _container.runtimeType == Home && isCurrentUserInitialized ?
        setFloatingActionButton("Home") : _container.runtimeType == Profile && isCurrentUserInitialized ?
        setFloatingActionButton("Profile") : null,
    );
  }
}
