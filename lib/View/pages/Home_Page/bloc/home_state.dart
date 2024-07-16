part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeActionState extends HomeState {}

final class ShowProgressState extends HomeState {}

final class ErrorState extends HomeState {}

final class UserListLoadedSuccessState extends HomeState {
  final List<UserListModel> userList;
  UserListLoadedSuccessState({required this.userList});
}

final class NavigateUserDetailsState extends HomeActionState {
  final UserListModel selectedUser;
  NavigateUserDetailsState({required this.selectedUser});
}
