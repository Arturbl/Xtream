import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/main/settings/card.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool _userIsAnonymous = false;


  set userIsAnonymous(bool value) {
    setState(() {
      _userIsAnonymous = value;
    });
  }

  void isUserAnonymous() async {
    User? currentFirebaseUser = await Auth.getCurrentUser();
    if(currentFirebaseUser != null) {
      if(currentFirebaseUser.isAnonymous) {
        userIsAnonymous = true;
      } else {
        userIsAnonymous = false;
      }
    }
    print('_userIsAnonymous: $_userIsAnonymous');
  }

  void closeSettingsWidget(dynamic action) async {
    await action;
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUserAnonymous();
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
