import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:xtream/main.dart';
import 'package:xtream/model/filter.dart';
import 'package:xtream/util/colors.dart';
import 'package:xtream/view/main/runApp.dart';


class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  _FilterWidgetState createState() => _FilterWidgetState();

}

class _FilterWidgetState extends State<FilterWidget> {

  late RangeValues _ageRange;
  late String _country;
  late String _gender;
  late String _ethnicity;

  void initFilter() {
    setState(() {
      _ageRange = RangeValues(widget.filter.ageRange.min.toDouble(), widget.filter.ageRange.max.toDouble());
      _gender = widget.filter.gender;
      _country = widget.filter.country;
      _ethnicity = widget.filter.ethnicity;
    });
  }

  void setGender(String value) {
    String gender;
    value == 'male' ? gender = 'male' : gender = 'female';
    setState(() {
      _gender = gender;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: PersonalizedColor.black
        ),
        padding: const EdgeInsets.all(10),
        height: 350,
        child: Column(
          children: [

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  const Text("Gender: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Text("Age: (" + _ageRange.start.toInt().toString() + " - " + _ageRange.end.toInt().toString() +  ")", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),


                    RangeSlider(
                      activeColor: PersonalizedColor.red,
                      values: _ageRange,
                      min: 18,
                      max: 100,
                      divisions: 100,
                      labels: RangeLabels(
                        _ageRange.start.round().toString(),
                        _ageRange.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _ageRange = values;
                        });
                      },
                    ),

                  ],
                )
            ),


            Container(
                padding: const EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width,
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

            Container(
              padding: const EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                child: Text(_ethnicity, style: TextStyle(color: Colors.white),),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white60)
                ),
                onPressed: () async {
                  String? value = await showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(1000, 600, 0, 0),
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
              padding: const EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  ElevatedButton(
                    child: const Text("Reset"),
                    onPressed: () {
                      widget.filter.has_changed = false;
                      widget.filter.ageRange.min = 18;
                      widget.filter.ageRange.max = 80;
                      widget.filter.country = "Country";
                      widget.filter.ethnicity = "Ethnicity";
                      widget.filter.gender = "Gender";
                      //widget.filter.price
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => RunApp(filter: widget.filter))
                      );
                    },
                  ),

                  ElevatedButton(
                    child: const Text("Apply filters"),
                    onPressed: () {
                      widget.filter.has_changed = true;
                      widget.filter.ageRange.min = _ageRange.start.toInt();
                      widget.filter.ageRange.max = _ageRange.end.toInt();
                      widget.filter.country = _country;
                      widget.filter.ethnicity = _ethnicity;
                      widget.filter.gender = _gender;
                      //widget.filter.price
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => RunApp(filter: widget.filter))
                      );
                    },
                  )

                ],
              ),
            )

          ],
        )
    );
  }
}
