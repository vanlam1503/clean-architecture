
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

abstract class UserDetailService {
  Future<Result<UserDetailDTO>> fetch(int id);
}

class UserDetailServiceImpl extends UserDetailService {

  final ApiClient _apiClient;
  UserDetailServiceImpl(this._apiClient);

  @override
  Future<Result<UserDetailDTO>> fetch(int id) async {
    var router = UserDetailRouter(id: id);
    var response = await _apiClient.fetch(router);
    var value = response.value;
    var json = jsonDecode(value!);
    var userDetail = UserDetailDTO.fromJSON(json);
    return Result.success(userDetail);
   }
}