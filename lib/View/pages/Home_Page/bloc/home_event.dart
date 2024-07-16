part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final String page_id;
  HomeInitialEvent({required this.page_id});
}

class UserSearchEvent extends HomeEvent {
  final String searchQuery;
  UserSearchEvent({required this.searchQuery});
}

class GoToDetailsEvent extends HomeEvent {
  final UserListModel selectedUser;
  GoToDetailsEvent({required this.selectedUser});
}
