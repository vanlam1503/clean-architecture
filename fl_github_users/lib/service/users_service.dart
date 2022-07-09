import 'dart:convert';

import 'package:fl_github_users/api_client/api_client.dart';
import 'package:fl_github_users/model/user_dto.dart';

class UsersRouter implements Router {

  @override
  String get uri => "https://api.github.com/users";
  @override
  Method get method => Method.get;
  @override
  Map<String, String>? headers;
}

abstract class UserService {
  Future<Result<List<UserDTO>>> fetch();
}

class UserServiceImpl extends UserService {

  final ApiClient _apiClient;
  UserServiceImpl(this._apiClient);

  @override
  Future<Result<List<UserDTO>>> fetch() async {
    var router = UsersRouter();
    var response = await _apiClient.fetch(router);
    var body = jsonDecode(response.value!);
    List<UserDTO> users = [];
    for (Map<String, dynamic> json in body) {
      var user = UserDTO.fromJSON(json);
      users.add(user);
    }
    return Result.success(users);
  }
}