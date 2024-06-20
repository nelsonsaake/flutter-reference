import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/candidate.dart';
import 'package:semper_web/dio_models/message_response.dart';

mixin CandidateCacheMixin on Client {
  // ...

  static bool _didFetchAll = false;

  static int? _electionId;

  static clear(){
    _didFetchAll = false;
    _electionId = null;
  }

  // ...

  static final Map<int, Candidate> _candidates = {};

  // get candidates

  Future _getCandidates(int electionId) async {
    debugPrint("[CandidateCacheMixin] getting candidates from server");

    final resp = await super.getCandidates(electionId: electionId);

    _candidates.clear();
    for (Candidate candidate in resp.candidates ?? []) {
      final id = candidate.id;
      if (id != null) _candidates[id] = candidate;
    }

    _electionId = electionId;
    _didFetchAll = true;
  }

  @override
  Future<CandidateListResponse> getCandidates({required int electionId}) async {
    debugPrint("[CandidateCacheMixin] getting candidates");

    if (_candidates.isEmpty || _electionId != electionId || !_didFetchAll) {
      await _getCandidates(electionId);
    }

    return CandidateListResponse(
      message: "get candidates successful",
      status: "ok",
      candidates: _candidates.values.toList(),
    );
  }

  // handle CandidateResponse

  handleCandidateResponse(CandidateResponse resp) {
    final v = resp.candidate;
    if (v == null) {
      debugPrint("got a null candidate backfrom server");
      throw "something went wrong";
    }

    final vId = v.id;
    if (vId == null) {
      debugPrint("got candidate backfrom server with no id");
      throw "something went wrong";
    }

    _candidates[vId] = v;
  }

  // create candidate

  Future<int> _createCandidate(String file, Candidate candidate) async {
    debugPrint("[CandidateCacheMixin] creating candidate with server");
    final resp = await super.createCandidate(file, candidate);
    handleCandidateResponse(resp);
    return resp.candidate!.id!;
  }

  @override
  Future<CandidateResponse> createCandidate(
    String file,
    Candidate candidate,
  ) async {
    debugPrint("[CandidateCacheMixin] creating candidate");
    final id = await _createCandidate(file, candidate);
    return CandidateResponse(
      message: "create candidate successful",
      status: "ok",
      candidate: _candidates[id],
    );
  }

  // get candidate by id

  Future _getCandidate(int id) async {
    debugPrint("[CandidateCacheMixin] getting candidate($id) from server");
    final resp = await super.getCandidate(id);
    return handleCandidateResponse(resp);
  }

  @override
  Future<CandidateResponse> getCandidate(int id) async {
    debugPrint("[CandidateCacheMixin] getting candidate($id)");

    if (_candidates[id] == null) {
      await _getCandidate(id);
    }

    return CandidateResponse(
      message: "get candidate successful",
      status: "ok",
      candidate: _candidates[id],
    );
  }

  // update candidate

  Future _updateCandidate(int id, Candidate candidate) async {
    debugPrint("[CandidateCacheMixin] updating candidate($id) with server");
    final resp = await super.updateCandidate(id, candidate);
    return handleCandidateResponse(resp);
  }

  @override
  Future<CandidateResponse> updateCandidate(
    int id,
    Candidate candidate,
  ) async {
    debugPrint("[CandidateCacheMixin] updating candidate($id)");
    await _updateCandidate(id, candidate);
    return CandidateResponse(
      message: "update candidate successful",
      status: "ok",
      candidate: _candidates[id],
    );
  }

  // delete candidate

  Future _deleteCandidate(int id) async {
    debugPrint("[CandidateCacheMixin] deleting candidate($id) with server");
    await super.deleteCandidate(id);
    _candidates.remove(id);
  }

  @override
  Future<MessageResponse> deleteCandidate(int id) async {
    debugPrint("[CandidateCacheMixin] deleting candidate($id)");
    await _deleteCandidate(id);
    return MessageResponse(
      message: "delete candidate successful",
      status: "ok",
    );
  }
}
