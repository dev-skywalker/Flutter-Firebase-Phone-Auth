part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
  const UserState();
}

class UserInitial extends UserState {}

class CreateUserState extends UserState {
  final DocumentSnapshot userData;
  CreateUserState(this.userData);
  @override
  List<Object> get props => [userData];
}
class LoadingState extends UserState {}