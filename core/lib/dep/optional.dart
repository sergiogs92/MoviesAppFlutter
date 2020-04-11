import 'package:meta/meta.dart';

@sealed
abstract class Optional<T> {
  factory Optional(T value) => (value == null) ? _None() : _Some(value);

  Optional<R> flatMap<R>(Optional<R> transform(T value));

  Optional<R> map<R>(R transform(T value));

  T or(T defaultValue());

  Optional<T> ifValue(void body(T value));

  Optional<T> ifNull(void body());

  T get value;
}

class _Some<T> implements Optional<T> {
  final T _value;

  _Some(this._value);

  @override
  T get value => _value;

  @override
  Optional<R> flatMap<R>(Optional<R> transform(T value)) => transform(_value);

  @override
  Optional<R> map<R>(R transform(T value)) => Optional(transform(_value));

  @override
  T or(T defaultValue()) => _value;

  @override
  Optional<T> ifValue(void body(T value)) {
    body(_value);
    return this;
  }

  @override
  Optional<T> ifNull(void body()) => this;

  @override
  String toString() {
    return '$_value';
  }
}

class _None<T> implements Optional<T> {
  @override
  T get value => null;

  @override
  Optional<R> flatMap<R>(Optional<R> transform(T value)) => _None();

  @override
  Optional<R> map<R>(R transform(T value)) => _None();

  @override
  T or(T defaultValue()) => defaultValue();

  @override
  Optional<T> ifValue(void body(T value)) => this;

  @override
  Optional<T> ifNull(void body()) {
    body();
    return this;
  }

  @override
  String toString() {
    return 'Optional.null';
  }
}
