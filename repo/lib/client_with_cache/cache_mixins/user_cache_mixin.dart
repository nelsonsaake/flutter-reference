import 'package:flutter/foundation.dart';
import 'package:semper_web/client/client.dart';
import 'package:semper_web/dio_models/message_response.dart';
import 'package:semper_web/dio_models/user.dart';

mixin UserCacheMixin on Client {
  static final Map<int, User> _users = {};

  static clear(){
    _users.clear();
  }

  // get users

  Future _getUsers() async {
    debugPrint("[UserCacheMixin] getting users from server");

    final resp = await super.getUsers();

    _users.clear();
    for (User user in resp.users ?? []) {
      final id = user.id;
      if (id != null) _users[id] = user;
    }
  }

  @override
  Future<UserListResponse> getUsers() async {
    debugPrint("[UserCacheMixin] getting users");

    if (_users.isEmpty) {
      await _getUsers();
    }

    return UserListResponse(
      message: "get users successful",
      status: "ok",
      users: _users.values.toList(),
    );
  }

  // handle UserResponse

  handleUserResponse(UserResponse resp) {
    final v = resp.user;
    if (v == null) {
      debugPrint("got a null user backfrom server");
      throw "something went wrong";
    }

    final vId = v.id;
    if (vId == null) {
      debugPrint("got user backfrom server with no id");
      throw "something went wrong";
    }

    _users[vId] = v;
  }

  // create user

  Future<int> _createUser(User user) async {
    debugPrint("[UserCacheMixin] creating user with server");
    final resp = await super.createUser(user);
    handleUserResponse(resp);
    return resp.user!.id!;
  }

  @override
  Future<UserResponse> createUser(User user) async {
    debugPrint("[UserCacheMixin] creating user");
    final id = await _createUser(user);
    return UserResponse(
      message: "create user successful",
      status: "ok",
      user: _users[id],
    );
  }

  // get user by id

  Future _getUser(int id) async {
    debugPrint("[UserCacheMixin] getting user($id) from server");
    final resp = await super.getUser(id);
    return handleUserResponse(resp);
  }

  @override
  Future<UserResponse> getUser(int id) async {
    debugPrint("[UserCacheMixin] getting user($id)");

    if (_users[id] == null) {
      await _getUser(id);
    }

    return UserResponse(
      message: "get user successful",
      status: "ok",
      user: _users[id],
    );
  }

  // update user

  Future _updateUser(int id, User user) async {
    debugPrint("[UserCacheMixin] updating user($id) with server");
    final resp = await super.updateUser(id, user);
    return handleUserResponse(resp);
  }

  @override
  Future<UserResponse> updateUser(
    int id,
    User user,
  ) async {
    debugPrint("[UserCacheMixin] updating user($id)");
    await _updateUser(id, user);
    return UserResponse(
      message: "update user successful",
      status: "ok",
      user: _users[id],
    );
  }

  // delete user

  Future _deleteUser(int id) async {
    debugPrint("[UserCacheMixin] deleting user($id) with server");
    await super.deleteUser(id);
    _users.remove(id);
  }

  @override
  Future<MessageResponse> deleteUser(int id) async {
    debugPrint("[UserCacheMixin] deleting user($id)");
    await _deleteUser(id);
    return MessageResponse(
      message: "delete user successful",
      status: "ok",
    );
  }
}
