import 'package:dio/dio.dart';

import 'dio_error_interpreter.dart';

// this calss is only necessary because the backend doesn't send user friendly error
// it's basically a hack
class ErrorInterpreter {
  // offline error

  static const offlineError = "you're currently offline";

  static bool isOfflineError(String error) {
    return error.trim() == offlineError.trim();
  }

  // email already taken error

  static const emailTakenError = "email already taken";

  // for handling unknown exceptions

  static String interpretException(Exception e) {
    return "error 234: please contact developer: \n$e";
  }

  // decide how the error should be interpreted

  static String _firstPass(e) {
    switch (e.runtimeType) {
      case String:
        return e;
      case DioException:
        return DioExceptionInterpreter().interpret(e);
      case Exception:
        return interpretException(e);
      default:
        return "unknown error: $e";
    }
  }

  static bool contains(String s1, String s2) {
    return s1.toLowerCase().contains(s2.toLowerCase());
  }

  static bool endsWith(String s1, String s2) {
    return s1.toLowerCase().endsWith(s2.toLowerCase());
  }

  static replaceFirst(String s1, String s2, String s3) {
    return s1.toLowerCase().replaceFirst(s2.toLowerCase(), s3.toLowerCase());
  }

  static replaceAll(String s1, String s2, String s3) {
    return s1.toLowerCase().replaceAll(s2.toLowerCase(), s3.toLowerCase());
  }

  static String _secondPass(String raw) {
    switch (raw) {
      case "no such host":
        return offlineError;
      case "The remote computer refused the network connection.":
        return "Server temporarily offline. Try again later."; // server not online
      case "":
      case "invalid syntax":
        return "Something went wrong";
    }

    const err1 = [
      "xml",
      "http",
      "xmlhttprequest",
      "xmlhttprequest error",
    ];
    for (var e in err1) {
      if (contains(raw, e)) {
        return "Something went wrong, please try again.";
      }
    }

    if (contains(raw, 'is has')) {
      raw = replaceFirst(raw, 'is has', 'has');
    }

    if (endsWith(raw, "unique constraint failed: user.email")) {
      return emailTakenError;
    }

    const err7 = "failed on the 'required' tag";
    if (contains(raw, err7)) {
      return _secondPass(replaceAll(raw, err7, "required"));
    }

    if (contains(raw, "(") != contains(raw, ")")) {
      return _secondPass(replaceAll(raw, "(", "").replaceAll(")", ""));
    }

    const err8 = "field validation for";
    if (contains(raw, err8)) {
      return _secondPass(replaceAll(raw, err8, ""));
    }

    const err9 = [
      "error getting jwt map claims",
      "error parsing token string",
      "token contains an invalid number of segments",
      "error casting results: <nil>",
    ];
    for (var err in err9) {
      if (contains(raw, err)) {
        return "Please login again.";
      }
    }

    const err10 = [
      "socketException",
      "the remote computer refused the network connection."
    ];
    for (var err in err10) {
      if (contains(raw, err)) {
        return "Can't connect to servers: make sure you're online and try again.";
      }
    }

    if (contains(raw, ":")) {
      return _secondPass(raw.split(":").last.trim());
    }

    return raw;
  }

  static String interpret(e) {
    String firstPass = _firstPass(e);
    return _secondPass(firstPass).trim();
  }
}
