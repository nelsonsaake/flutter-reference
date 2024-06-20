import 'package:dio/dio.dart';
import 'package:semper_web/errors/is_token_expired_error.dart';

// is token expired error
bool isTokenError(dynamic e) {
  if (isTokenExpiredError(e)) return true;
  switch (e.runtimeType) {
    case DioException:
      switch (e.type) {
        case DioExceptionType.badResponse:
          if (e.response?.data is Map<String, dynamic>) {
            final raw = e.response.data["message"];
            const targetErr =
                "error getting jwt map claims: "
                "error parsing token string: "
                "token contains an invalid number of segments: "
                "error casting results:";
            for (var err in targetErr.split(":")) {
              if (raw.contains(err)) {
                return true;
              }
            }
          }
      }
  }
  return false;
}
