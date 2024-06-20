import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/verification_method.dart';
import 'package:semper_web/dio_models/verification_method_list_response.dart';

mixin VerificationMethodCacheMixin on Client {

  static final Set<VerificationMethod> _verificationMethods = {};

  static clear(){
    _verificationMethods.clear();
  }

  Future _getVerificationMethods() async {
    debugPrint(
      "[VerificationMethodCacheMixin] getting"
      "verification methods from server",
    );
    final resp = await super.getVerificationMethods();
    _verificationMethods.clear();
    if (resp.verificationMethods == null) return;
    _verificationMethods.addAll(resp.verificationMethods!);
  }

  @override
  Future<VerificationMethodListResponse> getVerificationMethods() async {
    debugPrint("[VerificationMethodCacheMixin] getting verification methods");
    if (_verificationMethods.isEmpty) {
      await _getVerificationMethods();
    }
    return VerificationMethodListResponse(
      message: "get verification method successful",
      status: "ok",
      verificationMethods: _verificationMethods.toList(),
    );
  }
}
