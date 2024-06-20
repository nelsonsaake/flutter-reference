import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/string_response.dart';

mixin ElectionCodeCacheMixin on Client {
  // Map<ElectionId, ElectionCode>

  static final _electionCode = <int, String>{};

  static clear(){
  }

  // get elecion code

  Future _getVotersCount(int electionId) async {
    debugPrint("[ElectionCodeCacheMixin] getting election code from server");
    final resp = await super.getElectionCode(electionId);
    final code = resp.data;
    if (code != null) _electionCode[electionId] = code;
  }

  @override
  Future<StringResponse> getElectionCode(int electionId) async {
    debugPrint("[ElectionCodeCacheMixin] getting election code");

    if (_electionCode[electionId] == null) {
      await _getVotersCount(electionId);
    }

    return StringResponse(
      message: "get election code successful",
      status: "ok",
      data: _electionCode[electionId],
    );
  }
}
