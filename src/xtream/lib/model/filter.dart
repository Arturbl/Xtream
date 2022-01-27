

import 'package:xtream/util/tuple.dart';

class Filter {

  bool _has_changed = false; // control atribute to check if user has changed the filter

  String _country = 'Country';
  final Tuple _ageRange = Tuple<int, int>(18,80);
  String _ethnicity = 'Ethnicity';
  String _gender = 'Gender';
  double _price = 0;


  bool get has_changed => _has_changed;

  set has_changed(bool value) {
    _has_changed = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }


  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  Tuple get ageRange => _ageRange;

  set ageRange(Tuple range) {
    _ageRange.x = range.x;
    _ageRange.y = range.y;
  }

  String get ethnicity => _ethnicity;

  set ethnicity(String value) {
    _ethnicity = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }
}