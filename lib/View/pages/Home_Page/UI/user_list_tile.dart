import 'package:flutter/material.dart';
import 'package:impacteers/Model/Home_model/user_list_model.dart';
import 'package:impacteers/View/pages/Home_Page/bloc/home_bloc.dart';
import 'package:impacteers/res/colors.dart';
import 'package:impacteers/res/constant.dart';

class User_List_Tile extends StatelessWidget {
  final HomeBloc bloc;
  final UserListModel userList;
  const User_List_Tile({
    super.key,
    required this.bloc,
    required this.userList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc.add(GoToDetailsEvent(selectedUser: userList));
      },
      child: SizedBox(
        height: AppConstants.screenWidth * 0.35,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: userList.id,
                  child: Container(
                    width: AppConstants.screenWidth * 0.33,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Image.network(
                        userList.avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userList.first_name,
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor,
                          ),
                        ),
                        Text(
                          userList.last_name,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 11,
                            color: Colors.black38,
                          ),
                        ),
                        /* Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 16,
                              color: AppColors.green,
                            ),
                            SizedBox(width: 8), // Adjust the space between the icon and text as needed
                            Text(
                              userList.email,
                              style: TextStyle(
                                fontSize: 11,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                        Spacer() */
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
