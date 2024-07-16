// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteers/Model/Home_model/user_list_model.dart';
import 'package:impacteers/View/pages/Home_Page/bloc/home_bloc.dart';
import 'package:impacteers/View/pages/Home_Page/user_list_tile.dart';
import 'package:impacteers/View/pages/User_Details_Page/user_details.dart';
import 'package:impacteers/res/colors.dart';
import 'package:impacteers/res/constant.dart';
import 'package:impacteers/res/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();
  String page_id = '1';

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent(page_id: page_id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _homeAppbar(),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        builder: (context, state) {
          if (state is ShowProgressState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return Center(child: Text("Error"));
          } else if (state is UserListLoadedSuccessState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: AppColors.whiteLite,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(75),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _searchContent(),
                    SizedBox(height: 30),
                    _UserList(state.userList),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        listener: (context, state) {
          if (state is NavigateUserDetailsState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1000),
                reverseTransitionDuration: Duration(milliseconds: 1000),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: UserDetails(),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  AppBar _homeAppbar() {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(
        AppStrings.appName.toUpperCase(),
        style: TextStyle(
          wordSpacing: 8,
          letterSpacing: 4,
          fontSize: 18,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Column _searchContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.searchUser,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 20,
        ),
        TextField(
          autocorrect: true,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.black38,
            hintText: AppStrings.search,
            hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide.none,
            ),
            fillColor: AppColors.white,
            filled: true,
            contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          ),
        ),
      ],
    );
  }

  Widget _UserList(List<UserListModel> userLists) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: userLists.length,
        itemBuilder: (context, index) {
          UserListModel item = userLists[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: User_List_Tile(
              bloc: homeBloc,
              userList: item,
            ),
          );
        },
      ),
    );
  }
}
