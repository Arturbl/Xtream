import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void connect() async {
    print("trying to connect");
    final socket = await Socket.connect('192.168.1.88', 65432);
    socket.write("which");
    socket.listen((data) {

      print(data);

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Hello Xtream")
      )
    );
  }
}
