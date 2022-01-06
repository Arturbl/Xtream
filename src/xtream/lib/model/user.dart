

class User{

  late String _name;
  late int _age;
  late String _id;
  late double _evaluation;
  late int _numOfCalls;
  late String _country;
  late String _profileImageUrl;

  User(this._id, this._name);

  int get numOfCalls => _numOfCalls;

  set numOfCalls(int value) {
    _numOfCalls = value;
  }


  String get profileImageUrl => _profileImageUrl;

  set profileImageUrl(String value) {
    _profileImageUrl = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  double get evaluation => _evaluation;

  set evaluation(double value) {
    _evaluation = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}