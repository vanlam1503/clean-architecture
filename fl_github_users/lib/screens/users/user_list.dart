import 'package:fl_github_users/api_client/api_client.dart';
import 'package:fl_github_users/model/user_dto.dart';
import 'package:fl_github_users/screens/user_detail/user_detail.dart';
import 'package:fl_github_users/screens/users/user_item.dart';
import 'package:fl_github_users/service/users_service.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserList.instance();
}

class _UserList extends State<UserList> {
  UserService userService;
  _UserList({required this.userService});

  factory _UserList.instance() {
    ApiClientImpl apiClient = ApiClientImpl();
    UserService userService = UserService(apiClient: apiClient);
    return _UserList(userService: userService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: FutureBuilder<Result<List<UserDTO>>>(
          future: userService.fetch(),
          builder: (ctx, snapShot) {
            if ((snapShot.hasData) && (snapShot.requireData.value != null)) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: SizedBox(
                        height: 80,
                        child: UserItem(user: snapShot.requireData.value![index]),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => UserDetail(
                                    user: snapShot.requireData.value![index])));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 0.5,
                      indent: 15,
                    );
                  },
                  itemCount: snapShot.requireData.value!.length);
            } else {
              return const Center(
                child: Text("No data"),
              );
            }
          },
        ));
  }
}
