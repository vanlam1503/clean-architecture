import 'package:flutter/material.dart';

class UserItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserItem();
}

class _UserItem extends State<UserItem> {
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        height: 60,
        child: Row(
      children: [
        Container(
          width: 60,
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network('https://avatars.githubusercontent.com/u/1?v=4'),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text("hello",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: const Text("hello worlds",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
              )
            ],
          ),
        )
      ],
    )
    );
  }
}