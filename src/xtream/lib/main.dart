import 'package:flutter/material.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/util/RouteGenerator.dart';
import 'package:xtream/view/main/runApp.dart';

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
      title: 'Xtream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RunApp(filter: Filter(),),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


