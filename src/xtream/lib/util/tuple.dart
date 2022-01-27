

class Tuple<T1, T2> {

  late T1 _x;
  late T2 _y;

  Tuple(T1 x, T2 y) {
    _x = x;
    _y = y;
  }

  T2 get y => _y;

  set y(T2 value) {
    _y = value;
  }

  T1 get x => _x;

  set x(T1 value) {
    _x = value;
  }
}