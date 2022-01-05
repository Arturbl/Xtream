import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xtream/view/mainContainers/calls.dart';
import 'package:xtream/view/mainContainers/config.dart';
import 'package:xtream/view/mainContainers/home.dart';
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

  Color black = Color.fromRGBO(0, 0, 20, 0.5);
  Color red = Color.fromRGBO(130, 0, 0, 0.75);
  late Widget _container;

  void setContainer(Widget newContainer) {
    setState(() {
      _container = newContainer;
    });
    Navigator.pop(context);
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
      body: Container(
        color: black,
        alignment: Alignment.center,
        child: _container,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Builder(
        builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FloatingActionButton(
              // elevation: 0,
              // foregroundColor: Colors.red,
              backgroundColor: Colors.black,
              child: Icon(Icons.menu, color: red, size: 25,),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                          color: red,
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              IconButton(
                                icon: Icon(Icons.home, color: black,),
                                onPressed:() => setContainer(Home()),
                              ),

                              IconButton(
                                icon: Icon(Icons.call, color: black,),
                                onPressed:() => setContainer(Calls()),
                              ),

                              IconButton(
                                icon: Icon(Icons.person, color: black,),
                                onPressed:() => setContainer(Profile()),
                              ),

                              IconButton(
                                icon: Icon(Icons.settings, color: black,),
                                onPressed:() => setContainer(Config()),
                              ),

                            ],
                          )
                      );
                    }
                );
              },
            )
        ),
      ),
    );
  }
}

