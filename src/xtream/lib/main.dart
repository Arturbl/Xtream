import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/util/RouteGenerator.dart';
import 'package:xtream/view/main/runApp.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xtream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    )
  );
}

class App extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDmWrkZe9yB1644pZXwhqHGVdLSxXd5bKM",
        appId: "1:172635378345:web:58d966b7641839a1cbcfb8",
        messagingSenderId: "172635378345",
        projectId: "xtream-7cb96",
      )
  );

  @override
  Widget build(BuildContext context) { //RunApp(filter: Filter())
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text("Something went wrong " + snapshot.error.toString());
        }
        if(snapshot.connectionState == ConnectionState.done) {
          return RunApp(filter: Filter());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}


