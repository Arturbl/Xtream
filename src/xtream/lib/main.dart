import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xtream/view/home.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Xtream"),
          backgroundColor: Colors.red,
        ),
        body: const Home()
      ),
    );



  }
}
