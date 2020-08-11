part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  List<Object> get props => [];
  const AuthEvent();
}
class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthEvent {
  final String token;

  LoggedIn({@required this.token});

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}
class CheckPermanentUser extends AuthEvent{
  @override
  String toString() => 'CheckPermanentUser';
}
