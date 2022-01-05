import 'dart:ffi';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<Widget> displayNames(List<String> recvNames) {
    List<Widget> names = [];
    for(String name in recvNames) {
      Widget cont = Card(
        child: Text(name),
      );
      names.add(cont);
    }
    return names;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: displayNames(["Chloe", "Kim", "Daniela", "Laura"]),
        )
      ),
    );
  }
}
