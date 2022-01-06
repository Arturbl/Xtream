

class Tuple {

  late int _min;
  late int _max;

  Tuple(int min, int max) {
    _min = min;
    _max = max;
  }

  int get max => _max;

  set max(int value) {
    _max = value;
  }

  int get min => _min;

  set min(int value) {
    _min = value;
  }
}