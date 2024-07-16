import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:impacteers/Controller/Repository/home_repo/home_repo.dart';
import 'package:impacteers/Model/Home_model/user_list_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _api = HomeRepository();
  List<UserListModel> _userList = [];

  HomeBloc() : super(ShowProgressState()) {
    on<HomeInitialEvent>(fetchLists);
    on<UserSearchEvent>(filterUserList);
    on<AddUsersEvent>(addUserList);
    on<GoToDetailsEvent>(
      (event, emit) {
        emit(NavigateUserDetailsState(selectedUser: event.selectedUser));
      },
    );
  }

  FutureOr<void> addUserList(AddUsersEvent event, Emitter<HomeState> emit) async {
    List<dynamic> data;

    Map<String, dynamic> params = {'page': event.page_id.toString()};

    try {
      final response = await _api.getUserList(params);
      data = response["data"];

      if (data.isNotEmpty) _userList.addAll(data.map<UserListModel>((element) => UserListModel.fromMap(element)).toList());

      emit(UserListLoadedSuccessState(userList: _userList));
    } catch (e) {
      log("$e");
      emit(ErrorState());
      throw Exception(e);
    }
  }

  FutureOr<void> fetchLists(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(ShowProgressState());

    await Future.delayed(
      Duration(seconds: 1),
    );

    List<dynamic> data;

    Map<String, dynamic> params = {'page': event.page_id.toString()};

    try {
      final response = await _api.getUserList(params);
      data = response["data"];

      _userList = data.map<UserListModel>((element) => UserListModel.fromMap(element)).toList();

      emit(UserListLoadedSuccessState(userList: _userList));
    } catch (e) {
      log("$e");
      emit(ErrorState());
      throw Exception(e);
    }
  }

  FutureOr<void> filterUserList(UserSearchEvent event, Emitter<HomeState> emit) async {
    List<UserListModel> _filterList = [];

    if (event.searchQuery.isNotEmpty) {
      _filterList = _userList.where((element) {
        return element.first_name.toLowerCase().contains(event.searchQuery) || element.last_name.toLowerCase().contains(event.searchQuery);
      }).toList();
      emit(UserListLoadedSuccessState(userList: _filterList));
    } else {
      emit(UserListLoadedSuccessState(userList: _userList));
    }
  }
}
