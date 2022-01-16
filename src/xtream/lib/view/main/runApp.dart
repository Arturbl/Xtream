import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xtream/model/filter.dart';
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

  bool userAuthenticated = false; // check if user is authenticated

  late Widget currentPage;
  int currentPageIndex = 0;

  late Widget _container;
  late Home home;

  void checkUserSession() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  void logout() {
    print("logging out");
  }

  void setContainer(Widget newContainer) {
    setState(() {
      _container = newContainer;
    });
    currentPage = newContainer;
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
                onPressed: filterUsers,
              )
          ),
        );
      case "Profile":
        return Builder(
          builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingActionButton(
                elevation: 10,
                backgroundColor: Colors.transparent,
                // label: const Text(""), // Filter
                child: const Icon(Icons.exit_to_app, size: 22),
                onPressed: logout,
              )
          ),
        );
    }
    return Container();
  }


  Future filterUsers() async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        builder: (context) {
          return FilterWidget(filter: widget.filter);
        }
    );
  }

  @override
  void initState() {
    super.initState();
    home = Home(filter: widget.filter);
    currentPage = home;
    _container = home;
    checkUserSession();
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
                  onPressed:() => setContainer(Messages()),
                ),

                IconButton(
                  icon: Icon(Icons.person, color: PersonalizedColor.black,),
                  onPressed:() {
                    if(userAuthenticated) {
                      setContainer(Profile());
                    } else{
                      Navigator.of(context).pushNamed('/login');
                    }
                  },
                ),

              ],
            )
        )
    );
  }
}
