class Lazy<T> {
  final T Function() _build;
  bool _isEvaluated = false;
  T _value;

  Lazy(this._build);

  T call() {
    if (!_isEvaluated) {
      _value = _build();
      _isEvaluated = true;
    }
    return _value;
  }
}
