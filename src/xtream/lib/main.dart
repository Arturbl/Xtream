import 'package:flutter/material.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/util/RouteGenerator.dart';
import 'package:xtream/view/main/login.dart';
import 'package:xtream/view/main/runApp.dart';

void main() {
  runApp(
      const App()
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  bool checkUserSession() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xtream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: checkUserSession() ? RunApp(filter: Filter()) : Login(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


