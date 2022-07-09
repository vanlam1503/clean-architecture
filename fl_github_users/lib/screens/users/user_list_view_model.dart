
import 'dart:async';
import 'dart:ffi';

import 'package:fl_github_users/api_client/api_client.dart';
import 'package:fl_github_users/model/user_dto.dart';
import 'package:fl_github_users/service/users_service.dart';

class UserListViewModel {

  UserService userService;
  UserListViewModel({required this.userService});

  final _streamController = StreamController<Result<List<UserDTO>>>.broadcast();
  Stream<Result<List<UserDTO>>> get result => _streamController.stream;

  void dispose() => _streamController.close();

  Future sink() async {
    final result = await userService.fetch();
    _streamController.sink.add(result);
  }
}