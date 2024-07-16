import 'package:flutter/material.dart';
import 'package:impacteers/Model/Home_model/user_list_model.dart';
import 'package:impacteers/res/constant.dart';

class UserDetails extends StatefulWidget {
  final UserListModel userLists;

  const UserDetails({super.key, required this.userLists});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    final UserListModel list = widget.userLists;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            child: Hero(
                tag: list.id,
                child: Image.network(
                  list.avatar,
                  width: AppConstants.screenWidth,
                  height: AppConstants.screenHeight * 0.5,
                  fit: BoxFit.cover,
                )),
          ),
        ],
      ),
    );
  }
}
