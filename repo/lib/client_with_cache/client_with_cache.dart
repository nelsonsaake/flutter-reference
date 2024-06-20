import 'package:dio/dio.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/client_with_cache/cache_mixins/candidate_cache_mixin.dart';
import 'package:semper_web/client_with_cache/cache_mixins/election_cache_mixin.dart';
import 'package:semper_web/client_with_cache/cache_mixins/election_code_cache_mixin.dart';
import 'package:semper_web/client_with_cache/cache_mixins/institution_cache_mixin.dart';
import 'package:semper_web/client_with_cache/cache_mixins/office_cache_mixin.dart';
import 'package:semper_web/client_with_cache/cache_mixins/office_scores_cache_mixin.dart';
import 'package:semper_web/client_with_cache/cache_mixins/user_cache_mixin.dart';
import 'package:semper_web/client_with_cache/cache_mixins/voter_cache_mixin.dart';

class ClientWithCache extends ClientImplementation
    with
        CandidateCacheMixin,
        ElectionCacheMixin,
        ElectionCodeCacheMixin,
        InstitutionCacheMixin,
        OfficeCacheMixin,
        UserCacheMixin,
        VoterCacheMixin,
        OfficeScoresCacheMixin {
  ClientWithCache(Dio dio, {String? baseUrl}) : super(dio, baseUrl: baseUrl);
  
  static clear() {
    CandidateCacheMixin.clear();
    ElectionCacheMixin.clear();
    ElectionCodeCacheMixin.clear();
    InstitutionCacheMixin.clear();
    OfficeCacheMixin.clear();
    UserCacheMixin.clear();
    VoterCacheMixin.clear();
    OfficeScoresCacheMixin.clear();
  }
}
