
import 'package:flutter/material.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/mainContainers/calls.dart';
import 'package:xtream/view/mainContainers/config.dart';
import 'package:xtream/view/mainContainers/home/home.dart';
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
      home: const RunApp()
    );
  }
}


class RunApp extends StatefulWidget {
  const RunApp({Key? key}) : super(key: key);

  @override
  _RunAppState createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {

  late Widget _container;
  bool modalDown = true;

  void setContainer(Widget newContainer) {
    setState(() {
      _container = newContainer;
    });
    Navigator.pop(context);
  }

  Future showMenuModal() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: PersonalizedColor.red,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  IconButton(
                    icon: Icon(Icons.home, color: PersonalizedColor.black,),
                    onPressed:() => setContainer(Home()),
                  ),

                  IconButton(
                    icon: Icon(Icons.call, color: PersonalizedColor.black,),
                    onPressed:() => setContainer(Calls()),
                  ),

                  IconButton(
                    icon: Icon(Icons.person, color: PersonalizedColor.black,),
                    onPressed:() => setContainer(Profile()),
                  ),

                  IconButton(
                    icon: Icon(Icons.settings, color: PersonalizedColor.black,),
                    onPressed:() => setContainer(Config()),
                  ),

                ],
              )
          );
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _container = Home();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) => {if (details.delta.dx > 0) showMenuModal()},
        child: _container,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Builder(
        builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FloatingActionButton(
              mini: true,
              elevation: 10,
              // foregroundColor: Colors.red,
              backgroundColor: PersonalizedColor.red,
              child: Icon(Icons.menu, color: PersonalizedColor.black, size: 22),
              onPressed: showMenuModal,
            )
        ),
      ),
    );
  }
}

