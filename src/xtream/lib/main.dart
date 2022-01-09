
import 'package:flutter/material.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/main/filterWidget.dart';
import 'package:xtream/view/mainContainers/home/home.dart';
import 'package:xtream/view/mainContainers/messages/messages.dart';
import 'package:xtream/view/mainContainers/profile.dart';

void main() {
  runApp(
      const App()
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RunApp(filter: Filter(),)
    );
  }
}


class RunApp extends StatefulWidget {
  const RunApp({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _RunAppState createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {

  late Widget currentPage;
  int currentPageIndex = 0;

  late Widget _container;
  late Home home;


  void setContainer(Widget newContainer) {
    setState(() {
      _container = newContainer;
    });
    currentPage = newContainer;
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
      floatingActionButton: currentPage == home ? Builder(
        builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FloatingActionButton(
              elevation: 10,
              backgroundColor: PersonalizedColor.red,
              // label: const Text(""), // Filter
              child: const Icon(Icons.menu, size: 22),
              onPressed: filterUsers,
            )
        ),
      ) : null,
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
                onPressed:() => setContainer(Profile()),
              ),

            ],
          )
      )
    );
  }
}

