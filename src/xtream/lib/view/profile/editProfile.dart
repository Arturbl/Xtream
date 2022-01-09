import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/colors.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  String _ethnicity = 'Ethnicity';
  double _age = 18;
  String _gender = '';
  String _country = 'Country';
  List<String> _images = [];

  void setGender(String value) {
    String gender;
    value == 'male' ? gender = 'male' : gender = 'female';
    setState(() {
      _gender = gender;
    });
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
              child: Text("Save"),
              onPressed: () {

              },
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
                  onTap: () {
                    print("Opening camera");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    width: double.infinity,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                          radius: 35,
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
                    // controller: _controllerMensagem,
                    autofocus: false,
                    style: TextStyle(color: PersonalizedColor.white),
                    decoration: InputDecoration(
                      hintText: 'Name...',
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

                        Text("Age: (" + _age.toInt().toString() + ")", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),

                        Slider(
                          label: _age.toInt().toString(),
                          divisions: 100,
                          min: 18,
                          max: 100,
                          value: _age,
                          onChanged: (value) {
                            setState(() {
                              _age = value;
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
                          avatar: _gender == "male" ? CircleAvatar(
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
                          avatar: _gender == "female" ? CircleAvatar(
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
                          position: RelativeRect.fromLTRB(350, 200, 0, 0),
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
                        setState(() {
                          _ethnicity = value!;
                        });
                      },
                    )
                ),

                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: OutlinedButton(
                      child: Text(_country, style: TextStyle(color: Colors.white),),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white60)
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
