import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:impacteers/Controller/Repository/home_repo/home_repo.dart';
import 'package:impacteers/Model/Home_model/user_list_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(ShowProgressState()) {
    on<HomeInitialEvent>(fetchLists);
    on<GoToDetailsEvent>(
      (event, emit) {
        emit(NavigateUserDetailsState(userList: event.selectedUser));
      },
    );
  }
}

FutureOr<void> fetchLists(HomeInitialEvent event, Emitter<HomeState> emit) async {
  emit(ShowProgressState());

  List<dynamic> data;
  List<UserListModel> _userList = [];

  final HomeRepository _api = HomeRepository();
  Map<String, dynamic> params = {'page': event.page_id};

  try {
    await _api.getUserList(params).then(
          (value) => {
            data = value["data"],
            data.forEach(
              (element) {
                _userList.add(UserListModel.fromMap(element));
              },
            )
          },
        );

    emit(UserListLoadedSuccessState(userList: _userList));
  } catch (e) {
    log("$e");
    emit(ErrorState());
    throw Exception(e);
  }
}
