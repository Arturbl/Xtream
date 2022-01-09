import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xtream/util/colors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = new TextEditingController(text: 'arturesmavc@gmail.com');
  TextEditingController _passwordController = new TextEditingController(text: '123456');
  String _error1 = '';
  bool _loading = false;



  _validadeEmailAndPassword() {
    setState(() {
      _loading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;
    if(email.isNotEmpty && password.isNotEmpty) {
      if(email.contains('@')) {
        print("Starting login");
      } else {
        _setError('Enter a valid email');
      }
    } else {
      _setError('Check for missing fields');
    }
  }


  _setError(String error) {
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
        body: Container(
          decoration: BoxDecoration(
              color: PersonalizedColor.black,
          ),
          padding: const EdgeInsets.all(30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          ? Text('Login')
                          : CircularProgressIndicator(color: PersonalizedColor.black,),
                      padding: const EdgeInsets.all(14),
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
                        Navigator.pushNamed(context, '/account');
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
          ),
        )
    );
  }
}