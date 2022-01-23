import 'package:flutter/material.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/runApp.dart';

import 'card.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late User user;
  bool _userIsAnonymous = false;


  set userIsAnonymous(bool value) {
    setState(() {
      _userIsAnonymous = value;
    });
  }

  void initUser() async {
    user = await Auth.getCurrentUser();
    userIsAnonymous = user.isAnonymous;
  }

  void closeSettingsWidget(dynamic action) async {
    await action;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RunApp(filter: Filter())));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: PersonalizedColor.black,),
        onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Text('Settings', style: TextStyle(
        color: PersonalizedColor.black
        ),),
        backgroundColor: PersonalizedColor.red,
        ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: PersonalizedColor.black,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                _userIsAnonymous ?
                  SettingsCard(text: 'Login', action: () => closeSettingsWidget(Navigator.pushNamed(context, '/login'))) :
                  SettingsCard(text: 'Sign Out', action: () => closeSettingsWidget(Auth.signOut())),

                SettingsCard(text: 'Notifications', action: () => Navigator.pushNamed(context, '/notifications')),

                SettingsCard(text: 'Help', action: () => Navigator.pushNamed(context, '/notifications')),

                SettingsCard(text: 'Terms and conditions', action: () => Navigator.pushNamed(context, '/termsAndConditions')),


              ],
            )
        ),
      ),
    );
  }
}
