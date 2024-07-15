part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class UserListLoddedSuccessState extends HomeState {
  final List<UserListModel> userList;
  UserListLoddedSuccessState({required this.userList});
}

final class GoToDetailsState extends HomeActionState {
  final UserListModel userList;
  GoToDetailsState({required this.userList});
}
