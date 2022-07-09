
import 'dart:async';

import 'package:fl_github_users/api_client/api_client.dart';
import 'package:fl_github_users/model/user_detail_dto.dart';
import 'package:fl_github_users/service/user_detail_service.dart';

class UserDetailViewModel {

  UserDetailService service;

  UserDetailViewModel({required this.service});

  final _streamController = StreamController<Result<UserDetailDTO>>.broadcast();

  void dispose() => _streamController.close();

  Stream<Result<UserDetailDTO>> get result => _streamController.stream;

  void sink(int id) async {
    var result = await service.fetch(id);
    _streamController.add(result);
  }
}