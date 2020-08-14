part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
  const UserEvent();
}

class CreateUser extends UserEvent {
  String fullName;
  CreateUser(this.fullName);
}
