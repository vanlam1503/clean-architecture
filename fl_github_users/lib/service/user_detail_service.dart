
import 'dart:convert';

import 'package:fl_github_users/api_client/api_client.dart';
import 'package:fl_github_users/model/user_detail_dto.dart';

class UserDetailRouter implements Router {

  final int id;
  const UserDetailRouter({required this.id});

  @override
  Map<String, String>? get headers => null;

  @override
  Method get method => Method.get;

  @override
  String get uri => "https://api.github.com/users/$id";
}

class UserDetailService {

  final ApiClient apiClient;
  const UserDetailService({required this.apiClient});

  Future<UserDetailDTO> fetch(int id) async {
    var router = UserDetailRouter(id: id);
    var response = await apiClient.fetch(router);
    var body = jsonDecode(response.body);
    return UserDetailDTO.fromJSON(body);
   }
}