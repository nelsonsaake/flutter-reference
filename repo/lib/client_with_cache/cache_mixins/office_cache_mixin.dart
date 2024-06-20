import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/message_response.dart';
import 'package:semper_web/dio_models/office.dart';

mixin OfficeCacheMixin on Client {

  // election id for we which we are working with

  static bool _didFetchAll = false;

  static int? _electionId;

  static final Map<int, Office> _offices = {};

  static clear(){
    _didFetchAll = false;
    _electionId = null;
    _offices.clear();
  }

  // get offices

  Future _getOffices(int electionId) async {
    debugPrint("[OfficeCacheMixin] getting offices from server");

    final resp = await super.getOffices(electionId: electionId);
    _offices.clear();
    
    for (Office office in resp.offices ?? []) {
      final id = office.id;
      if (id != null) _offices[id] = office;
    }
    
    _electionId = electionId;
    _didFetchAll = true;
  }

  @override
  Future<OfficeListResponse> getOffices({required int electionId}) async {
    debugPrint("[OfficeCacheMixin] getting offices");

    if (_offices.isEmpty || _electionId != electionId || !_didFetchAll) {
      await _getOffices(electionId);
    }

    return OfficeListResponse(
      message: "get offices successful",
      status: "ok",
      offices: _offices.values.toList(),
    );
  }

  // handle OfficeResponse

  handleOfficeResponse(OfficeResponse resp) {
    final v = resp.office;
    if (v == null) {
      debugPrint("got a null office backfrom server");
      throw "something went wrong";
    }

    final vId = v.id;
    if (vId == null) {
      debugPrint("got office backfrom server with no id");
      throw "something went wrong";
    }

    _offices[vId] = v;
  }

  // create office

  Future<int> _createOffice(Office office) async {
    debugPrint("[OfficeCacheMixin] creating office with server");
    final resp = await super.createOffice(office);
    handleOfficeResponse(resp);
    return resp.office!.id!;
  }

  @override
  Future<OfficeResponse> createOffice(Office office) async {
    debugPrint("[OfficeCacheMixin] creating office");
    final id = await _createOffice(office);
    return OfficeResponse(
      message: "create office successful",
      status: "ok",
      office: _offices[id],
    );
  }

  // get office by id

  Future _getOffice(int id) async {
    debugPrint("[OfficeCacheMixin] getting office($id) from server");
    final resp = await super.getOffice(id);
    return handleOfficeResponse(resp);
  }

  @override
  Future<OfficeResponse> getOffice(int id) async {
    debugPrint("[OfficeCacheMixin] getting office($id)");

    if (_offices[id] == null) {
      await _getOffice(id);
    }

    return OfficeResponse(
      message: "get office successful",
      status: "ok",
      office: _offices[id],
    );
  }

  // update office

  Future _updateOffice(int id, Office office) async {
    debugPrint("[OfficeCacheMixin] updating office($id) with server");
    final resp = await super.updateOffice(id, office);
    return handleOfficeResponse(resp);
  }

  @override
  Future<OfficeResponse> updateOffice(
    int id,
    Office office,
  ) async {
    debugPrint("[OfficeCacheMixin] updating office($id)");
    await _updateOffice(id, office);
    return OfficeResponse(
      message: "update office successful",
      status: "ok",
      office: _offices[id],
    );
  }

  // delete office

  Future _deleteOffice(int id) async {
    debugPrint("[OfficeCacheMixin] deleting office($id) with server");
    await super.deleteOffice(id);
    _offices.remove(id);
  }

  @override
  Future<MessageResponse> deleteOffice(int id) async {
    debugPrint("[OfficeCacheMixin] deleting office($id)");
    await _deleteOffice(id);
    return MessageResponse(
      message: "delete office successful",
      status: "ok",
    );
  }
}
