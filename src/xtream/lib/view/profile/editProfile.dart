import 'dart:io' as io;

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:xtream/controller/main/firebaseStorageApi.dart';
import 'package:xtream/controller/main/firestoreApi.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';



class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final TextEditingController _nameController = TextEditingController();
  String _ethnicity = 'Ethicity';
  String _country = 'Country';


  late User currentUser;
  bool _loading = false;

  void updateLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }


  void selectProfileImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    await FirebaseStorageApi.uploadFile(file!, currentUser);
  }

  void setGender(String value) {
    String gender;
    value == 'male' ? gender = 'male' : gender = 'female';
    setState(() {
      currentUser.gender = gender;
    });
  }

  void initUserData() {
    setState(() {
      currentUser = widget.user;
      _ethnicity = currentUser.ethnicity.isNotEmpty ? currentUser.ethnicity : _ethnicity;
      _country = currentUser.country.isNotEmpty ? currentUser.country : _country;
    });
    setGender(currentUser.gender);
  }

  void saveData() async {
    updateLoading(true);
    currentUser.ethnicity = _ethnicity;
    currentUser.country = _country;
    currentUser.name = _nameController.text.isNotEmpty ? _nameController.text : currentUser.name;
    bool updated = await FirestoreControllerApi.updateUser(currentUser);
    if(updated) {
      Navigator.pop(context);
    }
    updateLoading(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUserData();
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
        backgroundColor: PersonalizedColor.red,
        title: Text("Edit profile", style: TextStyle(color: PersonalizedColor.black),),
        actions: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: _loading ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5) : const Text("Save"),
              onPressed: saveData,
            ),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(35),
            height: MediaQuery.of(context).size.height,
            color: PersonalizedColor.black,
            child: Column(
              children: [


                GestureDetector(
                  onTap: selectProfileImage,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    width: double.infinity,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                          radius: 35,
                          // backgroundImage: _profileImageAvatar.isEmpty ?
                          // const AssetImage('assets/images/profile_avatar.png') :
                          // Image.memory(_profileImageAvatar) as ImageProvider,
                          backgroundColor: Colors.grey,
                          child: Center(
                              child: Icon(Icons.camera_alt, color: Colors.white,)
                          )
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: _nameController,
                    autofocus: false,
                    style: TextStyle(color: PersonalizedColor.white),
                    decoration: InputDecoration(
                      hintText: currentUser.name,
                      hintStyle: TextStyle(color: PersonalizedColor.white),
                      filled: false,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person, color: PersonalizedColor.white,),
                    ),
                  ),
                ),

                Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Text("Age: (" + currentUser.age.toInt().toString() + ")", style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),

                        Slider(
                          label: currentUser.age.toInt().toString(),
                          divisions: 100,
                          min: 18,
                          max: 100,
                          value: currentUser.age.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              currentUser.age = value.toInt();
                            });
                          },
                        )

                      ],
                    )
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      const Text("Gender: ", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),

                      GestureDetector(
                        child: Chip(
                          backgroundColor: Colors.black.withOpacity(0.15),
                          label: const Text("Male"),
                          avatar: currentUser.gender == "male" ? CircleAvatar(
                            backgroundColor: PersonalizedColor.red,
                            child:const Icon(Icons.done, color: Colors.white,),
                          ) : null,
                        ),
                        onTap: () => setGender("male"),
                      ),

                      GestureDetector(
                        child: Chip(
                          backgroundColor: Colors.black.withOpacity(0.15),
                          label: const Text("Female"),
                          avatar: currentUser.gender == "female" ? CircleAvatar(
                            backgroundColor: PersonalizedColor.red,
                            child:const Icon(Icons.done, color: Colors.white,),
                          ) : null,
                        ),
                        onTap: () => setGender("female"),
                      ),

                    ],
                  ),
                ),


                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: OutlinedButton(
                      child: Text(_ethnicity, style: const TextStyle(color: Colors.white),),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white60)
                      ),
                      onPressed: () async {
                        String? value = await showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(350, 200, 0, 0),
                          items: [
                            const PopupMenuItem(child: Text("Blonde"), value: "Blonde",),
                            const PopupMenuItem(child: Text("Brunette"), value: "Brunette",),
                            const PopupMenuItem(child: Text("Red-haired"), value: "Red-haired",)
                            const PopupMenuItem(child: Text("Black"), value: "Black",)
                            const PopupMenuItem(child: Text("Latin"), value: "Latin",)
                            const PopupMenuItem(child: Text("Asian"), value: "Asian",)
                          ],
                          elevation: 8.0,
                        );
                        if( value != null ) {
                          setState(() {
                            _ethnicity = value;
                          });
                        }
                      },
                    )
                ),

                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: OutlinedButton(
                      child: Text(_country, style: const TextStyle(color: Colors.white),),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white60)
                      ),
                      onPressed: () {
                        showCountryPicker(
                            showPhoneCode: false,
                            context: context,
                            onSelect: (Country country) {
                              String countryName = country.displayName.split('[')[0];
                              if(countryName.isNotEmpty) {
                                setState(() {
                                  _country = countryName;
                                });
                              }
                            }
                        );
                      },
                    )
                ),

              ],
            )
        ),
      )
    );
  }
}
