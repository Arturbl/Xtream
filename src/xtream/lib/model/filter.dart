

import 'package:xtream/util/tuple.dart';

class Filter {

  String _country = 'Country';
  final Tuple _ageRange = Tuple(30,80);
  String _ethnicity = 'Ethnicity';
  String _gender = 'Gender';
  double _price = 0;

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
    _ageRange.min = range.min;
    _ageRange.max = range.max;
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