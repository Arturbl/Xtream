import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/messages/chat.dart';
import 'package:xtream/view/profile/editProfile.dart';


class RouteGenerator{

  static User toUser(final args) {
    return args as User;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch(settings.name) {
      case '/chat':
        return MaterialPageRoute(builder: (context) => Chat(toUser(args)));
      case '/editProfile':
        return MaterialPageRoute(builder: (context) => EditProfile(user: toUser(args)));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context){
      return Scaffold(
        backgroundColor: PersonalizedColor.black,
        body: Center(
          child: Text("Route not found", style: TextStyle(color: PersonalizedColor.red))
        )
      );
    });
  }

}