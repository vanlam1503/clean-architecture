import 'dart:convert';

import 'package:fl_github_users/api_client/api_client.dart';
import 'package:fl_github_users/model/user_dto.dart';

class UsersRouter implements Router {

  @override
  String get uri => "https://api.github.com/users";
  @override
  Method get method => Method.get;
  @override
  Map<String, String> get headers => { "": "" };
}

class UserService {

  final ApiClient apiClient;
  const UserService({required this.apiClient});

  Future<List<UserDTO>> fetch() async {
    var router = UsersRouter();
    var response = await apiClient.fetch(router);
    var body = jsonDecode(response.body);
    List<UserDTO> users = [];
    for (Map<String, dynamic> json in body) {
      var user = UserDTO.fromJSON(json);
      users.add(user);
    }
    return users;
  }
}