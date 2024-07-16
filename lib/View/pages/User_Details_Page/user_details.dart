import 'package:flutter/material.dart';
import 'package:impacteers/Model/Home_model/user_list_model.dart';
import 'package:impacteers/res/colors.dart';
import 'package:impacteers/res/constant.dart';
import 'package:impacteers/res/strings.dart';

class UserDetails extends StatefulWidget {
  final UserListModel userLists;

  const UserDetails({super.key, required this.userLists});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails>
    with TickerProviderStateMixin {
  late AnimationController cardPosController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 700));

  late Animation<double> cardPosAnimation =
      CurvedAnimation(parent: cardPosController, curve: Interval(0.0, 1));

  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 800),
      () {
        cardPosController.forward();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    cardPosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserListModel list = widget.userLists;

    return Scaffold(
      body: AnimatedBuilder(
          animation: cardPosAnimation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: AppConstants.screenWidth,
                  height: AppConstants.screenHeight,
                ),
                Positioned(
                  top: 0,
                  child: Hero(
                    tag: list.id,
                    child: Image.network(
                      opacity: AlwaysStoppedAnimation(0.6),
                      list.avatar,
                      width: AppConstants.screenWidth,
                      height: AppConstants.screenHeight * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: AppConstants.screenWidth,
                    height: AppConstants.screenHeight * 0.6,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: AppColors.whiteLite,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(75),
                      ),
                    ),
                    child: Opacity(
                      opacity: cardPosAnimation.value,
                      child: _infoContent(list),
                    ),
                  ),
                ),
                Positioned(
                  top: AppConstants.appBarHeight,
                  left: 25,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: CircleAvatar(
                      backgroundColor: AppColors.white.withOpacity(0.3),
                      child: Icon(
                        Icons.arrow_back_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Stack _infoContent(UserListModel list) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: AppConstants.screenHeight * 0.05,
          right: AppConstants.screenWidth / 2.8 * cardPosAnimation.value,
          child: Opacity(
            opacity: cardPosAnimation.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.white),
                  child: Center(
                    child: Text(
                      list.id,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  AppStrings.emp_code,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.colorPrimarySecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: AppConstants.screenHeight * 0.16,
          child: Container(
            width: AppConstants.screenWidth,
            height: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.colorPrimaryLite),
          ),
        ),

        // Owner Details Content
        Positioned(
          top: AppConstants.screenHeight * 0.18,
          left: 0,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: CircleAvatar(
                      radius: 30, backgroundImage: NetworkImage(list.avatar)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list.first_name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        list.last_name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: 0,
          top: AppConstants.screenHeight * 0.25,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Icon(
                  Icons.email,
                  size: 16,
                  color: AppColors.green,
                ),
                SizedBox(width: 8),
                Text(
                  list.email,
                  style: TextStyle(
                    fontSize: 11,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: AppConstants.screenHeight * 0.3,
          child: Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "At regione conclusionemque his, ius c Lorem ipsum dolor sit amet, consectetur adipisci ut labore et minim veniam, quis nostrud exercitation ullamco laboru corrumpit",
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: Colors.black38,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
