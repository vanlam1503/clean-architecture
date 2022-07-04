
import 'package:fl_github_users/model/user_dto.dart';
import 'package:fl_github_users/screens/users/user_item.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {

  final UserDTO user;
  const UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserDetail();
}

class _UserDetail extends State<UserDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User detail"),
      ),
      body: UserItem(user: widget.user),
    );
  }
}