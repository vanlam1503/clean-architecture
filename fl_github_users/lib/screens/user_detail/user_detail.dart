
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

  double width(BuildContext ctx) => MediaQuery.of(ctx).size.width;
  double height(BuildContext ctx) => MediaQuery.of(ctx).size.height;
  static const widgetCenterInsets = EdgeInsets.all(10);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User detail"),
      ),
      body: Container(

        child: Column(
          children: [
            header(),
            center(context), 
            footer(context)
          ],
        ),
      ),
    );
  }

  Widget header() {
    return SizedBox(
        height: 80,
        child: UserItem(user: widget.user));
  }

  Widget center(BuildContext context) {
    return Container(
      padding: widgetCenterInsets,
      height: 60,
      width: width(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          Flexible(
            child: Text("AboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutAboutsAboutAboutAboutAboutAboutAboutAboutAboutAbout",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w700)),
          ),
          Flexible(child:  Text("About",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400))),
        ],
      ),
    );
  }

  Widget footer(BuildContext context) {
    return Container(
      width: width(context),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: const Flexible(child: Text("Stat", maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left)),
          ),
          Container(
            height: 80,
            child: Row(
              children: [
                footerItem(context),
                footerItem(context),
                footerItem(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget footerItem(BuildContext context) {
    return Container(
      width: (width(context) - 20) / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const Text("90",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          const Flexible(child:  Text("About",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400))),        ],
      ),
    );
  }
}