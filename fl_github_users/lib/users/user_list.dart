import 'package:fl_github_users/users/user_item.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _UserList();
}

class _UserList extends State<UserList> {
  @override
  void initState() {
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
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Users"),
  //     ),
  //     body: ListView.builder(itemCount: 10,
  //     itemBuilder: (context, index) {
  //       return Container(
  //         height: 80,
  //         color: Colors.white,
  //         child: UserItem(),
  //       );
  //     }),
  //   );
  // }
}

