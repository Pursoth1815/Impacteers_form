import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:impacteers/Controller/Repository/home_repo/home_repo.dart';
import 'package:impacteers/Model/Home_model/user_list_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _api = HomeRepository();
  List<UserListModel> _userList = [];
  int maxCount = 0;

  HomeBloc() : super(ShowProgressState()) {
    on<HomeInitialEvent>(fetchLists);
    on<UserSearchEvent>(filterUserList);
    on<AddUsersEvent>(addUserList);
    on<GoToDetailsEvent>(fetchUserDetails);
  }

  FutureOr<void> fetchUserDetails(
      GoToDetailsEvent event, Emitter<HomeState> emit) async {
    Map<String, dynamic> data;
    UserListModel model;

    try {
      final response = await _api.getUserDetails(event.selectedUser.id);
      data = response["data"];

      model = UserListModel.fromMap(data);

      emit(NavigateUserDetailsState(selectedUser: model));
    } catch (e) {
      emit(ErrorState());
      throw Exception(e);
    }
  }

  FutureOr<void> addUserList(
      AddUsersEvent event, Emitter<HomeState> emit) async {
    emit(ContentLoadingState(
        userList: _userList, maxReached: _userList.length < maxCount));

    await Future.delayed(
      Duration(seconds: 1),
    );
    List<dynamic> data;

    Map<String, dynamic> params = {'page': event.page_id.toString()};

    try {
      if (_userList.length < maxCount) {
        final response = await _api.getUserList(params);
        data = response["data"];
        maxCount = response["total"];

        if (data.isNotEmpty)
          _userList.addAll(data
              .map<UserListModel>((element) => UserListModel.fromMap(element))
              .toList());

        emit(UserListLoadedSuccessState(
            userList: _userList, maxReached: _userList.length < maxCount));
      }
    } catch (e) {
      emit(ErrorState());
      throw Exception(e);
    }
  }

  FutureOr<void> fetchLists(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(ShowProgressState());

    await Future.delayed(
      Duration(seconds: 1),
    );

    List<dynamic> data;

    Map<String, dynamic> params = {'page': event.page_id.toString()};

    try {
      final response = await _api.getUserList(params);
      data = response["data"];
      maxCount = response["total"];

      _userList = data
          .map<UserListModel>((element) => UserListModel.fromMap(element))
          .toList();

      emit(UserListLoadedSuccessState(
          userList: _userList, maxReached: _userList.length < maxCount));
    } catch (e) {
      emit(ErrorState());
      throw Exception(e);
    }
  }

  FutureOr<void> filterUserList(
      UserSearchEvent event, Emitter<HomeState> emit) async {
    List<UserListModel> _filterList = [];
    if (event.searchQuery.isNotEmpty) {
      _filterList = _userList.where((element) {
        return element.first_name
                .toLowerCase()
                .contains(event.searchQuery.toLowerCase()) ||
            element.last_name
                .toLowerCase()
                .contains(event.searchQuery.toLowerCase());
      }).toList();

      emit(UserListLoadedSuccessState(userList: _filterList));
    } else {
      emit(UserListLoadedSuccessState(userList: _userList));
    }
  }
}
