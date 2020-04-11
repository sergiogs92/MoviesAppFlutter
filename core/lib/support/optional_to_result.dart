import 'package:core/dep/optional.dart';
import 'package:core/dep/result.dart';

extension OptionalToResult<T> on Optional<T> {
  Result<T, OptionalConversionError> toResult() {
    return map((value) => Result<T, OptionalConversionError>.success(value)).or(
        () => Result.failure(
            OptionalConversionError(OptionalConversionErrorCode.nullValue)));
  }
}

class OptionalConversionError {
  final OptionalConversionErrorCode code;

  OptionalConversionError(this.code);
}

enum OptionalConversionErrorCode { nullValue }
