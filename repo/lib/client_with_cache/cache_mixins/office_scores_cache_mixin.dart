import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/office_scores.dart';
import 'package:semper_web/dio_models/office_scores_response.dart';

mixin OfficeScoresCacheMixin on Client {
  // time to live

  static const Duration _ttl = Duration(minutes: 1);

  // office scores

  static final Map<int, OfficeScores> _officeScores = {};

  static final Map<int, DateTime> _lastServerRequestTimestamps = {};

  static clear(){
  }

  // time base cache

  _shouldGetFreshData(int id) {
    final lastServerRequest = _lastServerRequestTimestamps[id];
    if (lastServerRequest == null) return true;
    final timePassed = lastServerRequest.difference(DateTime.now());
    return timePassed > _ttl;
  }

  // get office scores from server

  Future _getOfficeScores(int officeId) async {
    debugPrint("[GetOfficeScoresCacheMixin] getting scores from server");
    final resp = await super.getOfficeScores(officeId);
    final v = resp.officeScores;
    if (v == null) return;
    _officeScores[officeId] = v;
    _lastServerRequestTimestamps[officeId] = DateTime.now();
  }

  @override
  Future<OfficeScoresResponse> getOfficeScores(int officeId) async {
    debugPrint("[GetOfficeScoresCacheMixin] getting scores");

    if (_shouldGetFreshData(officeId)) {
      await _getOfficeScores(officeId);
    }

    return OfficeScoresResponse(
      message: "get office scores successful",
      status: "ok",
      officeScores: _officeScores[officeId],
    );
  }
}
