import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:semper_web/cache/cache_auth.dart';
import 'package:semper_web/dio_models/candidate_scores.dart';
import 'package:semper_web/dio_models/office_scores.dart';
import 'package:semper_web/endpoints/endpoints_latest_host.dart';

class LiveUpdateService with ChangeNotifier {
  // singleton

  LiveUpdateService._internal();

  static LiveUpdateService _singleton = LiveUpdateService._internal();

  factory LiveUpdateService() {
    return _singleton;
  }

  // this will be returned if the actual candidates list is empty
  // this is useful for initial data

  final List<CandidateScores> _candidatesPlaceholder = [];

  List<OfficeScores> _officesPlaceholder = [];

  set officesPlaceholder(List<OfficeScores> v) {
    _officesPlaceholder = v;
    _candidatesPlaceholder.clear();

    for (var os in v) {
      for (CandidateScores cs in os.candidates ?? []) {
        _candidatesPlaceholder.add(cs);
      }
    }

    notifyListeners();
  }

  // candidates raw list from stream

  final List<CandidateScores> _candidates = [];

  List<CandidateScores> get candidates =>
      _candidates.isEmpty ? _candidatesPlaceholder : _candidates;

  // office

  List<OfficeScores> _offices = [];

  List<OfficeScores> get offices =>
      _offices.isEmpty ? _officesPlaceholder : _offices;

  set offices(List<OfficeScores> v) {
    _offices = v;
    _candidates.clear();

    for (var os in v) {
      for (CandidateScores cs in os.candidates ?? []) {
        _candidates.add(cs);
      }
    }

    notifyListeners();
  }

  // new url

  String newUrl(int electionId) {
    return "$latestHost/elections/$electionId/live";
  }

  // live update

  Stream<SSEModel>? _liveUpdateStream;

  StreamSubscription<SSEModel>? _subscription;

  void getLiveUpdate(int electionId) {
    _subscription?.cancel();

    _liveUpdateStream = SSEClient.subscribeToSSE(
      url: newUrl(electionId),
      header: CacheAuth().authDetails?.authHeaders ?? {},
    );

    _subscription = _liveUpdateStream?.listen((event) {
      final data = event.data;
      if (data is! String) return;

      final scoresMap = jsonDecode(data);
      if (scoresMap is! List) return;

      final scores = scoresMap.map((score) {
        return OfficeScores.fromJson(score);
      }).toList();

      offices = scores;
    });
  }

  void setPlaceholder(List<OfficeScores> v) {
    officesPlaceholder = v;
  }

  void clear(){
    _singleton = LiveUpdateService._internal();
  }
}
