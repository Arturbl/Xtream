

class User{

  late bool _isAnonymous = true;
  String _name = '';
  int _age = 0;
  String _uid = '';
  double _evaluation = 0.0;
  String _country = '';
  Map<String, dynamic> imagesUrls = {'profile': '', 'other': []};
  String _ethnicity = '';
  String _gender = '';
  String _email = '';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'uid': uid,
      'evaluation': evaluation,
      'country': country,
      'images': imagesUrls,
      'ethnicity': ethnicity,
      'gender': gender,
      'email': email
    };
  }

  bool get isAnonymous => _isAnonymous;

  set isAnonymous(bool value) {
    _isAnonymous = value;
  }

  void setProfileImage(String url) {
    imagesUrls['profile'] = url;
  }

  void addImage(String url) {
    imagesUrls['other'].add(url);
  }

  set images(List<dynamic> images) {
    imagesUrls['other'] = images;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }


  String get email => _email;

  set email(String value) {
    _email = value;
  }


  String get ethnicity => _ethnicity;

  set ethnicity(String value) {
    _ethnicity = value;
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

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}