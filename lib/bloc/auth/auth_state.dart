part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
  const AuthState();
}

class AuthInitial extends AuthState {}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  final DocumentSnapshot userData;
  Authenticated(this.userData);
  @override
  List<Object> get props => [userData];
}

class NotHaveUserData extends AuthState{}

class Unauthenticated extends AuthState {}

class Loading extends AuthState {}

class WarningFreeUser extends AuthState {}

class WarningPermanentUser extends AuthState {}