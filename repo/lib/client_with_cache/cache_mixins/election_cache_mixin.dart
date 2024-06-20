import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/election.dart';
import 'package:semper_web/dio_models/election_mutation_request.dart';
import 'package:semper_web/dio_models/election_verification_method_list_response.dart';
import 'package:semper_web/dio_models/message_response.dart';

mixin ElectionCacheMixin on Client {
  //

  static final Map<int, Election> _elections = {};

  static final Map<int, List<int>> _electionVerificationMethod = {};


  static clear(){
    _elections.clear();
    _electionVerificationMethod.clear();
  }

  // get elections

  Future _getElections(int institutionId) async {
    debugPrint("[ElectionCacheMixin] getting elections from server");

    final resp = await super.getElections(institutionId: institutionId);

    _elections.clear();
    for (Election election in resp.elections ?? []) {
      final id = election.id;
      if (id != null) _elections[id] = election;
    }
  }

  @override
  Future<ElectionListResponse> getElections({
    required int institutionId,
  }) async {
    debugPrint("[ElectionCacheMixin] getting elections");

    if (_elections.isEmpty) {
      await _getElections(institutionId);
    }

    return ElectionListResponse(
      message: "get elections successful",
      status: "ok",
      elections: _elections.values.toList(),
    );
  }

  // handle ElectionResponse

  handleElectionResponse(ElectionResponse resp) {
    final v = resp.election;
    if (v == null) {
      debugPrint("got a null election backfrom server");
      throw "something went wrong";
    }

    final vId = v.id;
    if (vId == null) {
      debugPrint("got election backfrom server with no id");
      throw "something went wrong";
    }
    
    _elections[vId] = v;
    _electionVerificationMethod.remove(vId);
  }

  // create election

  Future<int> _createElection(ElectionMutationRequest election) async {
    debugPrint("[ElectionCacheMixin] creating election with server");
    final resp = await super.createElection(election);
    handleElectionResponse(resp);
    return resp.election!.id!;
  }

  @override
  Future<ElectionResponse> createElection(
    ElectionMutationRequest election,
  ) async {
    debugPrint("[ElectionCacheMixin] creating election");
    final id = await _createElection(election);
    return ElectionResponse(
      message: "create election successful",
      status: "ok",
      election: _elections[id],
    );
  }

  // get election by id

  Future _getElection(int id) async {
    debugPrint("[ElectionCacheMixin] getting election($id) from server");
    final resp = await super.getElection(id);
    return handleElectionResponse(resp);
  }

  @override
  Future<ElectionResponse> getElection(int id) async {
    debugPrint("[ElectionCacheMixin] getting election($id)");

    if (_elections[id] == null) {
      await _getElection(id);
    }

    return ElectionResponse(
      message: "get election successful",
      status: "ok",
      election: _elections[id],
    );
  }

  // update election

  Future _updateElection(int id, ElectionMutationRequest election) async {
    debugPrint("[ElectionCacheMixin] updating election($id) with server");
    final resp = await super.updateElection(id, election);
    return handleElectionResponse(resp);
  }

  @override
  Future<ElectionResponse> updateElection(
    int id,
    ElectionMutationRequest election,
  ) async {
    debugPrint("[ElectionCacheMixin] updating election($id)");
    await _updateElection(id, election);
    return ElectionResponse(
      message: "update election successful",
      status: "ok",
      election: _elections[id],
    );
  }

  // delete election

  Future _deleteElection(int id) async {
    debugPrint("[ElectionCacheMixin] deleting election($id) with server");
    await super.deleteElection(id);
    _elections.remove(id);
    _electionVerificationMethod.remove(id);
  }

  @override
  Future<MessageResponse> deleteElection(int id) async {
    debugPrint("[ElectionCacheMixin] deleting election($id)");
    await _deleteElection(id);
    return MessageResponse(
      message: "delete election successful",
      status: "ok",
    );
  }

  // get Election verification method

  Future _getElectionVerificationMethods(int electionId) async {
    debugPrint(
      "[ElectionCacheMixin] getting election($electionId) "
      "verification methods from server",
    );
    final resp = await super.getElectionVerificationMethods(electionId);
    final vms = resp.data;
    if (vms == null) return;
    _electionVerificationMethod[electionId] = vms;
  }

  @override
  Future<IntListResponse> getElectionVerificationMethods(int electionId) async {
    debugPrint(
      "[ElectionCacheMixin] getting election($electionId) "
      "verification methods",
    );

    if (_electionVerificationMethod[electionId] == null) {
      await _getElectionVerificationMethods(electionId);
    }

    return IntListResponse(
      message: "get election successful",
      status: "ok",
      data: _electionVerificationMethod[electionId],
    );
  }

  // toggle election pause
 
  Future _togglePauseElection(int id) async {
    debugPrint("[ElectionCacheMixin] toggling pause election($id) with server");
    final resp = await super.startPauseElection(id);
    return handleElectionResponse(resp);
  }

  @override
  Future<ElectionResponse> startPauseElection(int id) async {
    debugPrint("[ElectionCacheMixin] toggling pause election($id)");
    await _togglePauseElection(id);
    return ElectionResponse(
      message: "toggle pause election successful",
      status: "ok",
      election: _elections[id],
    );
  }

  // end election 
 
  Future _endElection(int id) async {
    debugPrint("[ElectionCacheMixin] ending election($id) with server");
    final resp = await super.endElection(id);
    return handleElectionResponse(resp);
  }

  @override
  Future<ElectionResponse> endElection(int id) async {
    debugPrint("[ElectionCacheMixin] ending election($id)");
    await _endElection(id);
    return ElectionResponse(
      message: "end election successful",
      status: "ok",
      election: _elections[id],
    );
  }
}
