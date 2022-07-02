import 'package:fl_github_users/screens/users/user_item.dart';
import 'package:fl_github_users/service/api_client.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _UserList();
}

class _UserList extends State<UserList> {
  @override
  void initState() {
    var router = user
    // var apiClient = ApiClient();
    // apiClient.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: ListView.separated(itemBuilder: (context, index) {
        return Container(
          height: 80,
          color: Colors.white,
          child: UserItem(),
        );
      }, separatorBuilder: (context, index) {
        return const Divider(
          thickness: 0.5,
          indent: 15,
        );
      }, itemCount: 10),
    );
  }
}

