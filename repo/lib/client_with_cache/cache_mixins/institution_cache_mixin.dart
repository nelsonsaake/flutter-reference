import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/institution.dart';
import 'package:semper_web/dio_models/message_response.dart';

mixin InstitutionCacheMixin on Client {
  static bool _didFetchAll = false;

  static final Map<int, Institution> _institutions = {};

  static clear(){
    _didFetchAll = false;
    _institutions.clear();
  }

  // get institutions

  Future _getInstitutions() async {
    debugPrint("[InstitutionCacheMixin] getting institutions from server");

    final resp = await super.getInstitutions();

    _institutions.clear();
    for (Institution institution in resp.institutions ?? []) {
      final id = institution.id;
      if (id != null) _institutions[id] = institution;
    }

    _didFetchAll = true;
  }

  @override
  Future<InstitutionListResponse> getInstitutions() async {
    debugPrint("[InstitutionCacheMixin] getting institutions");

    if (_institutions.isEmpty || !_didFetchAll) {
      await _getInstitutions();
    }

    return InstitutionListResponse(
      message: "get institutions successful",
      status: "ok",
      institutions: _institutions.values.toList(),
    );
  }

  // handle InstitutionResponse

  handleInstitutionResponse(InstitutionResponse resp) {
    final v = resp.institution;
    if (v == null) {
      debugPrint("got a null institution backfrom server");
      throw "something went wrong";
    }

    final vId = v.id;
    if (vId == null) {
      debugPrint("got institution backfrom server with no id");
      throw "something went wrong";
    }

    _institutions[vId] = v;
  }

  // create institution

  Future<int> _createInstitution(String file, Institution institution) async {
    debugPrint("[InstitutionCacheMixin] creating institution with server");
    final resp = await super.createInstitution(file, institution);
    handleInstitutionResponse(resp);
    return resp.institution!.id!;
  }

  @override
  Future<InstitutionResponse> createInstitution(
    String file,
    Institution institution,
  ) async {
    debugPrint("[InstitutionCacheMixin] creating institution");
    final id = await _createInstitution(file, institution);
    return InstitutionResponse(
      message: "create institution successful",
      status: "ok",
      institution: _institutions[id],
    );
  }

  // get institution by id

  Future _getInstitution(int id) async {
    debugPrint("[InstitutionCacheMixin] getting institution($id) from server");
    final resp = await super.getInstitution(id);
    return handleInstitutionResponse(resp);
  }

  @override
  Future<InstitutionResponse> getInstitution(int id) async {
    debugPrint("[InstitutionCacheMixin] getting institution($id)");

    if (_institutions[id] == null) {
      await _getInstitution(id);
    }

    return InstitutionResponse(
      message: "get institution successful",
      status: "ok",
      institution: _institutions[id],
    );
  }

  // update institution

  Future _updateInstitution(int id, Institution institution) async {
    debugPrint("[InstitutionCacheMixin] updating institution($id) with server");
    final resp = await super.updateInstitution(id, institution);
    return handleInstitutionResponse(resp);
  }

  @override
  Future<InstitutionResponse> updateInstitution(
    int id,
    Institution institution,
  ) async {
    debugPrint("[InstitutionCacheMixin] updating institution($id)");
    await _updateInstitution(id, institution);
    return InstitutionResponse(
      message: "update institution successful",
      status: "ok",
      institution: _institutions[id],
    );
  }

  // delete institution

  Future _deleteInstitution(int id) async {
    debugPrint("[InstitutionCacheMixin] deleting institution($id) with server");
    await super.deleteInstitution(id);
    _institutions.remove(id);
  }

  @override
  Future<MessageResponse> deleteInstitution(int id) async {
    debugPrint("[InstitutionCacheMixin] deleting institution($id)");
    await _deleteInstitution(id);
    return MessageResponse(
      message: "delete institution successful",
      status: "ok",
    );
  }
}
