import 'package:semper_web/cache/cache_int_list.dart';
import 'package:semper_web/cache/cache_with_write_encryption.dart';
import 'package:semper_web/services/live_update_service.dart';

class CacheService {
  static final _voterId = CacheWithWriteEncryption<int>('#1');

  static final _electionId = CacheWithWriteEncryption<int>('#2');

  static final _phoneNumber = CacheWithWriteEncryption<String>('#3');

  static final _electionCode = CacheWithWriteEncryption<String>('#4');

  static final _electionName = CacheWithWriteEncryption<String>('#5');

  static final _electionVerificationMethods = CacheIntList('#6');

  static final _selectedElectionId = CacheWithWriteEncryption<int>('#7');

  static final _selectedInstitutionId = CacheWithWriteEncryption<int>('#8');

  // voter id

  int get voterId {
    final v = _voterId.get();
    if (v == null) throw "voter id not set";
    return v;
  }

  set voterId(int v) {
    _voterId.set(v);
  }

  // election id

  int get activeElectionId {
    final v = _electionId.get();
    if (v == null) throw "election id not set";
    return v;
  }

  set activeElectionId(int v) {
    _electionId.set(v);
  }

  // selected election id

  int? get selectedElectionId {
    return _selectedElectionId.get();
  }

  set selectedElectionId(int? v) {
    _selectedElectionId.set(v);
    LiveUpdateService().clear();
  }

  // selected institution id

  int? get selectedInstitutionId {
    return _selectedInstitutionId.get();
  }

  set selectedInstitutionId(int? v) {
    _selectedInstitutionId.set(v);
  }

  // phone number

  String get phoneNumber {
    final v = _phoneNumber.get();
    if (v == null) throw "phoneNumber not set";
    return v;
  }

  set phoneNumber(String v) {
    _phoneNumber.set(v);
  }

  // election code

  String get electionCode {
    final v = _electionCode.get();
    if (v == null) throw "electionCode is not set";
    return v;
  }

  set electionCode(String v) {
    _electionCode.set(v);
  }

  // election name

  set electionName(String v) {
    _electionName.set(v);
  }

  String get electionName {
    final v = _electionName.get();
    if (v == null) throw "election name not set";
    return v;
  }

  // election name

  set electionVerificationMethods(List<int> v) {
    _electionVerificationMethods.set(v);
  }

  List<int> get electionVerificationMethods {
    final v = _electionVerificationMethods.get();
    return v ?? [];
  }

  // clear

  void clear() {
    _selectedElectionId.set(null);
    _selectedInstitutionId.set(null);
  }
}
