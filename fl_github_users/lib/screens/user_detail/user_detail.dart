
import 'package:fl_github_users/api_client/api_client.dart';
import 'package:fl_github_users/model/user_detail_dto.dart';
import 'package:fl_github_users/model/user_dto.dart';
import 'package:fl_github_users/screens/user_detail/user_detail_view_model.dart';
import 'package:fl_github_users/screens/users/user_item.dart';
import 'package:fl_github_users/service/user_detail_service.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {

  final UserDTO user;
  const UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserDetail.instance();
}

class _UserDetail extends State<UserDetail> {

  UserDetailViewModel viewModel;
  _UserDetail({required this.viewModel});

  factory _UserDetail.instance() {
    var apiClient = ApiClientImpl();
    var service = UserDetailServiceImpl(apiClient);
    var viewModel = UserDetailViewModel(service: service);
    return _UserDetail(viewModel: viewModel);
  }

  // Define
  double width(BuildContext ctx) => MediaQuery.of(ctx).size.width;
  double height(BuildContext ctx) => MediaQuery.of(ctx).size.height;
  static const widgetCenterInsets = EdgeInsets.all(10);
  double footerHeight = 100;
  static const footerInsets = EdgeInsets.fromLTRB(10, 0, 0, 10);
  static const double statHeaderHeight = 40;

  @override
  void initState() {
    viewModel.sink(widget.user.id);
    super.initState();
  }
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User detail"),
      ),
      body: StreamBuilder<Result<UserDetailDTO>>(
        stream: viewModel.result,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Column(
                children: [
                  header(),
                  center(context, snapShot.requireData.value!),
                  footer(context, snapShot.requireData.value!)
                ],
              );
          } else {
            return const Center(
              child: Text("No data"),
            );
          }
        },
      ),
    );
  }

  Widget header() {
    return SizedBox(
        height: 80,
        child: UserItem(user: widget.user));
  }

  Widget center(BuildContext context, UserDetailDTO userDetailDTO) {
    return Container(
      padding: widgetCenterInsets,
      height: 60,
      width: width(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          const Flexible(
            child: Text("About",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w700)),
          ),
          Flexible(child:  Text(userDetailDTO.bio.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400))),
        ],
      ),
    );
  }

  Widget footer(BuildContext context, UserDetailDTO userDetailDTO) {
    return Container(
      width: width(context),
      height: footerHeight,
      padding: footerInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: statHeaderHeight,
            child: Text("Stat", maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left),
          ),
          SizedBox(
            height: footerHeight - footerInsets.bottom - statHeaderHeight,
            child: Row(
              children: [
                footerItem(context, "PUBLIC REPO", userDetailDTO.publicRepos),
                footerItem(context, "FOLLOWERS", userDetailDTO.followers),
                footerItem(context, "FOLLOWING", userDetailDTO.following),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget footerItem(BuildContext context, String title, int number) {
    return SizedBox(
      width: (width(context) - footerInsets.left - footerInsets.right) / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text("$number",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          Flexible(child:  Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400)))],
      ),
    );
  }
}
