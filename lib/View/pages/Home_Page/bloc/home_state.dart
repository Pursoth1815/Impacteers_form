part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeActionState extends HomeState {}

final class HomeInitialState extends HomeState {}

final class UserListLoddedSuccessState extends HomeState {
  final List<UserListModel> userList;
  UserListLoddedSuccessState({required this.userList});
}

final class GoToUserDetailsState extends HomeActionState {
  final UserListModel userList;
  GoToUserDetailsState({required this.userList});
}
