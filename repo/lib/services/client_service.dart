import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:semper_web/cache/cache_auth.dart';
import 'package:semper_web/client_with_cache/client_with_cache.dart';
import 'package:semper_web/dio_models/auth_details.dart';
import 'package:semper_web/dio_models/credentials.dart';
import 'package:semper_web/dio_models/email.dart';
import 'package:semper_web/dio_models/voter_login_request.dart';
import 'package:semper_web/endpoints/endpoints_latest_host.dart';
import 'package:semper_web/errors/is_token_expired_error.dart';

typedef VoidCallback = void Function();

bool _usedloginfunc = false;

class ClientService extends CacheAuth {
  final String baseUrl;

  ClientService.respawn({this.baseUrl = latestHost}) {
    try {
      authDetails = CacheAuth().authDetails;
      if (authDetails != null) {
        _startAutoRefresh();
      }
    } catch (e) {
      //...
    }
  }

  ClientService({this.baseUrl = latestHost});

  ClientService.withAuthDetail(
    AuthDetails authDetails, {
    this.baseUrl = latestHost,
  }) {
    this.authDetails = authDetails;
    _startAutoRefresh();
  }

  // clear cached client data
  static clearCachedClientData() {
    ClientWithCache.clear();
  }

  // if signed in as user, this will user id
  // if signed in as voter, this will be the voter id
  int? get authId => authDetails?.id;

  // "Authorization": "bearer <accessToken>"
  Map<String, String> get authHeaders => authDetails?.authHeaders ?? {};

  // used login func
  Credentials? _credentials;

  // used for triggering refresh
  static Timer? _refreshTimer;
  static const _refreshDuration = Duration(minutes: 4);

  // client no authorization required
  // mostly used for logining
  ClientWithCache? _client;

  // new semper client with predefined config
  ClientWithCache newSemperClient([Dio? dio]) {
    // base url
    var baseUrl = this.baseUrl;
    if (kDebugMode) baseUrl = "http://localhost:5000";

    // dio setup
    dio ??= Dio();
    dio.options.headers.addAll(corsHeaders);

    // client setup
    return ClientWithCache(
      dio,
      baseUrl: baseUrl,
    );
  }

  // we don't need to re-create this one
  // so we cache it
  ClientWithCache get client {
    _client ??= newSemperClient();
    return _client!;
  }

  // main client, this is used more often
  // it allows access to authorized endpoints
  ClientWithCache get authClient {
    // unlike the client, authClient depends on auth tokens
    // tokens which may be expired after they are used to create the client
    // so we just create a new client every time we need one

    final dio = Dio(BaseOptions(headers: authDetails?.authHeaders));

    if (_usedloginfunc) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onError: (DioException e, ErrorInterceptorHandler handler) async {
            if (!isTokenExpiredError(e)) {
              return handler.reject(e);
            }

            RequestOptions? opt = e.response?.requestOptions;
            if (opt == null) {
              return handler.reject(e);
            }

            await _refresh().catchError((err, st) {
              _login().then((value) async {
                opt.headers.addAll(authDetails?.authHeaders ?? {});
                await dio.fetch(opt).then((res) {
                  return handler.resolve(res);
                });
              });
            });

            return handler.next(e);
          },
        ),
      );
    }

    return newSemperClient(dio);
  }

  // for refreshing the auth details
  // refresh gets us new tokens to access the system
  ClientWithCache get _refreshClient {
    final dio = Dio(BaseOptions(headers: authDetails?.refreshHeaders));
    return newSemperClient(dio);
  }

  // custom client
  ClientWithCache customClient(String token) {
    final authDetails = AuthDetails();
    authDetails.accessToken = token;

    final dio = Dio();
    dio.options.headers.addAll(authDetails.authHeaders);

    return newSemperClient(dio);
  }

  // cors headers, this might best place in a different package
  static Map<String, String> corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json",
    "Accept": "*/*",
  };

  // refresh auth tokens
  Future refreshAuth() async {
    final resp = await _refreshClient.refresh();
    authDetails = resp.authDetails;
  }

  Future _refresh() async {
    try {
      await refreshAuth();
    } catch (e) {
      _refreshTimer?.cancel();
      rethrow;
    }
  }

  Future _refreshQuiet() async {
    try {
      await _refresh();
    } catch (e) {
      //
    }
  }

  // refresh auth tokens after every _refreshDuration
  _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      _refreshDuration,
      (timer) => _refresh(),
    );
    return;
  }

  // LOGIN METHODS

  static const authDetailsNotProvidedErr =
      "Something went wrong. Please logout and login again.";

  // for voters with otp
  Future voterLogin(VoterLoginRequest req) async {
    final resp = await client.voterLogin(req);

    if (resp.authDetails == null) throw authDetailsNotProvidedErr;
    authDetails = resp.authDetails!;

    return _startAutoRefresh();
  }

  // for users of the system
  Future _login() async {
    final resp = await client.login(_credentials!);

    if (resp.authDetails == null) throw authDetailsNotProvidedErr;
    authDetails = resp.authDetails!;

    _usedloginfunc = true;

    return _startAutoRefresh();
  }

  Future login(String email, String password, bool rememberMe) async {
    _credentials = Credentials(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
    return await _login();
  }

  // check if the login email is verified before login
  Future verifyAndLogin(String email, String password, bool rememberMe,
      VoidCallback resendEmail, VoidCallback verifyEmail) async {
    final resp = await client.isEmailVerified(Email(email));

    switch (resp.data) {
      case true:
        return login(email, password, rememberMe);
      case false:
        resendEmail();
        verifyEmail();
        throw "email not verified.";
      default:
        return;
    }
  }

  logout() {
    _refreshTimer?.cancel();
    authClient.logout();
  }
}
