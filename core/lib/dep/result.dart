import 'package:meta/meta.dart';

@sealed
abstract class Result<S, E> {
  factory Result.success(S value) => _Success(value);

  factory Result.failure(E error) => _Failure(error);

  factory Result.catching(S body()) {
    try {
      return Result.success(body());
    } catch (error) {
      return Result.failure(error);
    }
  }

  Result<T, E> map<T>(T transform(S value));

  Result<S, F> mapError<F>(F transform(E error));

  Result<T, E> flatMap<T>(Result<T, E> transform(S value));

  Result<S, F> flatMapError<F>(Result<S, F> transform(E error));

  Result<S, E> onSuccess(void body(S value));

  Result<S, E> onError(void body(E error));

  S get();

  S or(S defaultValue());

  T fold<T>(T success(S value), T error(E error));

  bool get isSuccess;

  bool get isError;
}

class _Success<S, E> implements Result<S, E> {
  final S _value;

  _Success(this._value);

  @override
  Result<T, E> map<T>(T transform(S value)) => Result.success(transform(_value));

  @override
  Result<S, F> mapError<F>(F transform(E error)) => Result.success(_value);

  @override
  Result<T, E> flatMap<T>(Result<T, E> transform(S value)) => transform(_value);

  @override
  Result<S, F> flatMapError<F>(Result<S, F> transform(E error)) => Result.success(_value);

  @override
  Result<S, E> onSuccess(void body(S value)) {
    body(_value);
    return this;
  }

  @override
  Result<S, E> onError(void body(E error)) => this;

  @override
  S get() => _value;

  @override
  S or(S defaultValue()) => _value;

  @override
  T fold<T>(T success(S value), T error(E error)) => success(_value);

  @override
  bool get isSuccess => true;

  @override
  bool get isError => false;
}

class _Failure<S, E> implements Result<S, E> {
  final E _error;

  _Failure(this._error);

  @override
  Result<T, E> map<T>(T transform(S value)) => Result.failure(_error);

  @override
  Result<S, F> mapError<F>(F transform(E error)) => Result.failure(transform(_error));

  @override
  Result<T, E> flatMap<T>(Result<T, E> transform(S value)) => Result.failure(_error);

  @override
  Result<S, F> flatMapError<F>(Result<S, F> transform(E error)) => transform(_error);

  @override
  Result<S, E> onSuccess(void body(S value)) => this;

  @override
  Result<S, E> onError(void body(E error)) {
    body(_error);
    return this;
  }

  @override
  S get() => throw _error;

  @override
  S or(S defaultValue()) => defaultValue();

  @override
  T fold<T>(T success(S value), T error(E error)) => error(_error);

  @override
  bool get isSuccess => false;

  @override
  bool get isError => true;
}
