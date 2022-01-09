

class Tuple<T1, T2> {

  late T1 _min;
  late T2 _max;

  Tuple(T1 min, T2 max) {
    _min = min;
    _max = max;
  }

  T2 get max => _max;

  set max(T2 value) {
    _max = value;
  }

  T1 get min => _min;

  set min(T1 value) {
    _min = value;
  }
}