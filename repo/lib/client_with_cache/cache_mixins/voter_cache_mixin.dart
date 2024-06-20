import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/int_response.dart';
import 'package:semper_web/dio_models/message_response.dart';
import 'package:semper_web/dio_models/voter.dart';

mixin VoterCacheMixin on Client {
  // ...

  static bool _didFetchAll = false;

  static int? _electionId;

  // cahce

  static final Map<int, Voter> _voters = {};

  static final Map<int /*electionid*/, int /*voter count*/ > _voterCountMap =
      {};

  static clear (){
    _voters.clear();
    _voterCountMap.clear();
  }

  // clear voter count

  _clearVoterCount(int? electionId) {
    if (electionId == null) _voterCountMap.clear();
    _voterCountMap.remove(electionId);
  }

  // get voters

  Future _getVoters(int electionId) async {
    debugPrint("[VoterCacheMixin] getting voters from server");

    final resp = await super.getVoters(electionId: electionId);

    _clearVoterCount(electionId);
    _voters.clear();

    for (Voter voter in resp.voters ?? []) {
      final id = voter.id;
      if (id != null) _voters[id] = voter;
    }
    
    _electionId = electionId;
    _didFetchAll = true;
  }

  @override
  Future<VoterListResponse> getVoters({required int electionId}) async {
    debugPrint("[VoterCacheMixin] getting voters");

    if (_voters.isEmpty || _electionId != electionId || !_didFetchAll) {
      await _getVoters(electionId);
    }

    return VoterListResponse(
      message: "get voters successful",
      status: "ok",
      voters: _voters.values.toList(),
    );
  }

  // handle VoterResponse

  handleVoterResponse(VoterResponse resp) {
    final v = resp.voter;
    if (v == null) {
      debugPrint("got a null voter backfrom server");
      throw "something went wrong";
    }

    final vId = v.id;
    if (vId == null) {
      debugPrint("got voter backfrom server with no id");
      throw "something went wrong";
    }

    _voters[vId] = v;
  }

  // create voter

  Future<int> _createVoter(Voter voter) async {
    debugPrint("[VoterCacheMixin] creating voter with server");
    final resp = await super.createVoter(voter);
    handleVoterResponse(resp);
    _clearVoterCount(resp.voter!.electionId!);
    return resp.voter!.id!;
  }

  @override
  Future<VoterResponse> createVoter(Voter voter) async {
    debugPrint("[VoterCacheMixin] creating voter");
    final id = await _createVoter(voter);
    return VoterResponse(
      message: "create voter successful",
      status: "ok",
      voter: _voters[id],
    );
  }

  // get voter by id

  Future _getVoter(int id) async {
    debugPrint("[VoterCacheMixin] getting voter($id) from server");
    final resp = await super.getVoter(id);
    return handleVoterResponse(resp);
  }

  @override
  Future<VoterResponse> getVoter(int id) async {
    debugPrint("[VoterCacheMixin] getting voter($id)");

    if (_voters[id] == null) {
      await _getVoter(id);
    }

    return VoterResponse(
      message: "get voter successful",
      status: "ok",
      voter: _voters[id],
    );
  }

  // update voter

  Future _updateVoter(int id, Voter voter) async {
    debugPrint("[VoterCacheMixin] updating voter($id) with server");
    final resp = await super.updateVoter(id, voter);
    return handleVoterResponse(resp);
  }

  @override
  Future<VoterResponse> updateVoter(
    int id,
    Voter voter,
  ) async {
    debugPrint("[VoterCacheMixin] updating voter($id)");
    await _updateVoter(id, voter);
    return VoterResponse(
      message: "update voter successful",
      status: "ok",
      voter: _voters[id],
    );
  }

  // delete voter

  Future _deleteVoter(int id) async {
    debugPrint("[VoterCacheMixin] deleting voter($id) with server");
    await super.deleteVoter(id);
    _clearVoterCount(null);
    _voters.remove(id);
  }

  @override
  Future<MessageResponse> deleteVoter(int id) async {
    debugPrint("[VoterCacheMixin] deleting voter($id)");
    await _deleteVoter(id);
    return MessageResponse(
      message: "delete voter successful",
      status: "ok",
    );
  }

  // get voterCount

  Future _getVotersCount(int electionId) async {
    debugPrint("[VoterCacheMixin] getting voter count from server");
    final resp = await super.getVotersCount(electionId: electionId);
    final count = resp.data;
    if (count != null) _voterCountMap[electionId] = count;
  }

  @override
  Future<IntResponse> getVotersCount({required int electionId}) async {
    debugPrint("[VoterCacheMixin] getting voter count");

    if (_voterCountMap[electionId] == null) {
      await _getVotersCount(electionId);
    }

    return IntResponse(
      message: "get voter count successful",
      status: "ok",
      data: _voterCountMap[electionId],
    );
  }
}
