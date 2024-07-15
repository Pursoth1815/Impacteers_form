import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:impacteers/Controller/Repository/home_repo/home_repo.dart';
import 'package:impacteers/Model/Home_model/user_list_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //load list

  List<UserListModel> _userList = [];

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(fetchLists);
  }
}

FutureOr<void> fetchLists(
    HomeInitialEvent event, Emitter<HomeState> emit) async {
  final _api = HomeRepository();
  Map<String, dynamic> params = {'page': event.page_id};
  _api.getUserList(params).then((value) => {print(value)});
}
