import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart' as userClass;
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/home/filterWidget.dart';
import 'package:xtream/view/home/home.dart';
import 'package:xtream/view/messages/messages.dart';
import 'package:xtream/view/profile/profile.dart';

class RunApp extends StatefulWidget {
  const RunApp({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _RunAppState createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {

  late User? currentUser;

  int currentPageIndex = 0;

  late Widget _container;
  late Home home;

  void initUserSession() async{
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user == null) {
        print('User is currently signed out, Creating new anonymous session.');
        UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
        currentUser = userCredential.user;
      } else {
        print('User is signed in!');
        print('anonymous: ' + user.isAnonymous.toString());
        print('uid: ' + user.uid.toString());
        currentUser = user;
      }
    });
  }

  void setContainer(Widget newContainer) {
    setState(() {
      _container = newContainer;
    });
  }


  Widget setFloatingActionButton(String widgetType) {
    switch(widgetType) {
      case "Home":
        return Builder(
          builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingActionButton(
                elevation: 10,
                backgroundColor: PersonalizedColor.black1,
                // label: const Text(""), // Filter
                child: const Icon(Icons.menu, size: 22),
                onPressed: () async {
                  await showModal(FilterWidget(filter: widget.filter));
                },
              )
          ),
        );
      case "Profile":
        return Builder(
          builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingActionButton(
                elevation: 10,
                  backgroundColor: PersonalizedColor.black1,
                  // backgroundColor: Colors.transparent,
                // label: const Text(""), // Filter
                child:  const Icon(Icons.settings, size: 22),
                onPressed: () =>  Navigator.of(context).pushNamed('/settings')
              )
          ),
        );
    }
    return Container();
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

  @override
  void initState() {
    super.initState();
    home = Home(filter: widget.filter);
    _container = home;
    initUserSession();
  }

  @override
  void dispose() {
    super.dispose();
    _container;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _container,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: _container.runtimeType == Home ?
        setFloatingActionButton("Home") : _container.runtimeType == Profile ?
        setFloatingActionButton("Profile") : null,
        bottomNavigationBar: Container(
            color: PersonalizedColor.red,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(
                  icon: Icon(Icons.home, color: PersonalizedColor.black,),
                  onPressed:() => setContainer(home),
                ),

                IconButton(
                  icon: Icon(Icons.messenger_rounded, color: PersonalizedColor.black,),
                  onPressed:() => setContainer(const Messages()),
                ),

                IconButton(
                  icon: Icon(Icons.person, color: PersonalizedColor.black,),
                  onPressed:() => setContainer(Profile()),
                ),

              ],
            )
        )
    );
  }
}
