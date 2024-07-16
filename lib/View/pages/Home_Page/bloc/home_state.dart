part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeActionState extends HomeState {}

final class ShowProgressState extends HomeState {}

final class ContentLoadingState extends HomeState {
  final List<UserListModel> userList;
  final bool maxReached;

  ContentLoadingState({required this.userList, this.maxReached = false});
}

final class ErrorState extends HomeState {}

final class UserListLoadedSuccessState extends HomeState {
  final List<UserListModel> userList;
  final bool maxReached;
  UserListLoadedSuccessState({required this.userList, this.maxReached = false});
}

final class NavigateUserDetailsState extends HomeActionState {
  final UserListModel selectedUser;
  NavigateUserDetailsState({required this.selectedUser});
}
