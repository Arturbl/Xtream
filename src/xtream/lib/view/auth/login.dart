import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/util/sizing.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = new TextEditingController(text: 'arturesmavc@gmail.com');
  TextEditingController _passwordController = new TextEditingController(text: '1234567956526');
  String _error1 = '';
  bool _loading = false;



  void _validadeEmailAndPassword() async {
    setState(() {
      _loading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;
    if(email.isNotEmpty && password.isNotEmpty) {
      if(email.contains('@')) {
        String response = await Auth.signIn(email, password);
        if(response == "done") {
          Navigator.pop(context);
        } else {
          _setError(response);
        }
      } else {
        _setError('Enter a valid email');
      }
    } else {
      _setError('Check for missing fields');
    }
  }


  void _setError(String error) {
    setState(() {
      _error1 = error;
      _loading = false;
    });
    Timer(
        Duration(seconds: 5),
            (){
          setState(() {
            _error1 = '';
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        // icon: Icon(Icons.arrow_back_ios, color: PersonalizedColor.black,),
        // onPressed: () => Navigator.pop(context),
        // ),
        // titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Text('Login', style: TextStyle(
        color: PersonalizedColor.black
        ),),
        backgroundColor: PersonalizedColor.red,
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: PersonalizedColor.black,
        ),
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SizedBox(
            width:  Sizing.getScreenWidth(context),// MediaQuery.of(context).size.width * 0.65,
            child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    TextField(
                      controller: _emailController,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.email, color: PersonalizedColor.black)
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.vpn_key, color: PersonalizedColor.black)
                        ),
                      ),
                    ),

                    _error1 != null
                        ? Container(
                      //padding: EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(_error1, style: TextStyle(color: Colors.red, fontSize: 14)),
                      ),
                    )
                        : Container(),

                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: RaisedButton(
                        child:
                        _loading == false
                            ? Text('Login', style: TextStyle(color: PersonalizedColor.black, fontSize: Sizing.fontSize),)
                            : CircularProgressIndicator(color: PersonalizedColor.black,),
                        padding: const EdgeInsets.all(20),
                        textColor: Colors.white,
                        color: Colors.red,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.red
                            )
                        ),
                        onPressed: (){
                          _validadeEmailAndPassword();
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: (){
                          String email = _emailController.text;
                          Navigator.of(context).pushNamed('/createAccount', arguments: email);
                        },
                        child: const Center(
                          child: Text('Create new account', style: TextStyle(
                              color: Colors.blue
                          ),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
          )
        ),
      )
    );
  }
}