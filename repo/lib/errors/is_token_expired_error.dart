import 'package:dio/dio.dart';

// is token expired error
bool isTokenExpiredError(dynamic e) {
  switch (e.runtimeType) {
    case DioException:
      switch (e.type) {
        case DioExceptionType.badResponse:
          if (e.response?.data is Map<String, dynamic>) {
            return RegExp(
              r".*Token.*expired.*",
              caseSensitive: false,
              dotAll: true,
            ).hasMatch(
              e.response.data["message"],
            );
          }
      }
  }
  return false;
}
