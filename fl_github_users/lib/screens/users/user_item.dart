import 'package:fl_github_users/model/user_dto.dart';
import 'package:flutter/material.dart';

class UserItem extends StatefulWidget {
  final UserDTO user;

  const UserItem({Key? key, required this.user}): super(key: key);

  @override
  State<StatefulWidget> createState() => _UserItem();
}

class _UserItem extends State<UserItem> {
  double width(BuildContext ctx) => MediaQuery.of(ctx).size.width;
  double height(BuildContext ctx) => MediaQuery.of(ctx).size.height;

  // Define
  static const double imageLeftPadding = 10;
  static const double imageWidth = 60;
  static const double imageHeight = imageWidth;
  static const EdgeInsets textInsets = EdgeInsets.fromLTRB(10, 5, 20, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(imageLeftPadding, 0, 0, 0),
        height: 80,
        child: Row(
          children: [
            SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(imageHeight / 2),
                child: Image.network(widget.user.avatar),
              ),
            ),
            Container(
              padding: textInsets,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                    width: width(context) -
                        imageWidth -
                        imageLeftPadding -
                        textInsets.left -
                        textInsets.right,
                    child: Text(widget.user.login,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                      child: SizedBox(
                    width: width(context) -
                        imageWidth -
                        imageLeftPadding -
                        textInsets.left -
                        textInsets.right,
                    child: Text(widget.user.githubProfile,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ))
                ],
              ),
            )
          ],
        )
    );
  }
}
