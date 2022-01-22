import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtream/controller/main/auth.dart';
import 'package:xtream/util/colors.dart';

class CreateAccount extends StatefulWidget {

  final String email;

  const CreateAccount(this.email);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {


  //control ui
  bool _visible = false;
  String _visibleText = 'Continue';
  CrossAxisAlignment _align = CrossAxisAlignment.end;
  String _erro1 = '';
  bool _loading = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nomeController = new TextEditingController();
  TextEditingController _senhaController = new TextEditingController(text: "1234567956526");
  TextEditingController _senhaConfirmController = new TextEditingController(text: "1234567956526");


  void _checkNameAndEmail() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    if(nome.isNotEmpty && email.trim().isNotEmpty){
      if(email.contains('@')) {
        setState(() {
          _visible = true;
          _visibleText = 'Create';
          _align = CrossAxisAlignment.stretch;
        });
      } else {
        _setError('Enter a valid email');
      }
    } else {
      _setError('Check for missing fields');
    }
  }

  _setError(String error) {
    setState(() {
      _erro1 = error;
      _loading = false;
    });
    Timer(
        const Duration(seconds: 5),
            (){
          setState(() {
            _erro1 = '';
          });
        }
    );
  }

  void _verifyPasswordsMatch() async {
    setState(() {
      _loading = true;
    });
    String name = _nomeController.text;
    String email = _emailController.text;
    String pass = _senhaController.text;
    String confirmPass = _senhaConfirmController.text;
    if(pass.isNotEmpty && confirmPass.isNotEmpty) {
      if(pass.trim() == confirmPass.trim()) {
        if(pass.length >= 6) {
          String response = await Auth.registerNewUser(email, pass, name);
          if(response == "done") {
            Navigator.pop(context);
          } else {
            _setError(response);
          }
        } else {
          _setError('Password must have at least 6 characters');
        }
      } else {
        _setError('Passwords must match');
      }
    } else {
      _setError('Check for missing fields');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.email.isNotEmpty) {
      setState(() {
        _emailController.text = widget.email;
      });
    }

  }


  @override
  void dispose() {
    super.dispose();
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
          title: Text('Create new account', style: TextStyle(
            color: PersonalizedColor.black
          ),),
          backgroundColor: PersonalizedColor.red,
        ),
        body: Container(
          decoration: BoxDecoration(
              color: PersonalizedColor.black,
          ),
          padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: _align,
                children: [

                  TextField(
                    controller: _nomeController,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        prefixIcon: Icon(Icons.person, color: PersonalizedColor.black,)
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          prefixIcon: Icon(Icons.email, color: PersonalizedColor.black,)
                      ),
                    ),
                  ),


                  Visibility(
                    visible: _visible,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        obscureText: true,
                        controller: _senhaController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.vpn_key,color: PersonalizedColor.black)
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: _visible,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        obscureText: true,
                        controller: _senhaConfirmController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Confirm password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.vpn_key, color: PersonalizedColor.black)
                        ),
                      ),
                    ),
                  ),

                  _visible == true
                      ? Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/terms');
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: 'By clicking on create, you accept our ',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                                children: [
                                  TextSpan(
                                      text: 'terms and conditions', style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  )
                                  ),
                                ]
                            )
                        ),
                      )
                  )
                      : Container(),

                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: RaisedButton(
                      child:
                      _loading == false
                          ? Text(_visibleText, style: TextStyle(color: PersonalizedColor.black),)
                          : CupertinoActivityIndicator(),
                      padding: EdgeInsets.all(14),
                      textColor: Colors.white,
                      color: Colors.red,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.red
                          )
                      ),
                      onPressed: (){
                        if(_visible == false) {
                          _checkNameAndEmail();
                        } else {
                          _verifyPasswordsMatch();
                        }
                      },
                    ),
                  ),

                  _erro1 != null
                      ? Center(
                        child: Text(_erro1, style: TextStyle(color: Colors.red, fontSize: 14)),
                      )
                      : Container(),

                ],
              ),
            ),
          ),
        )
    );
  }
}