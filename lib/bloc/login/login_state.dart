part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  List<Object> get props => [];
  const LoginState();
}

class LoginInitial extends LoginState {}

class OtpSentState extends LoginState {}

class LoadingState extends LoginState {}

class OtpVerifiedState extends LoginState {}

class LoginCompleteState extends LoginState {
  FirebaseUser _firebaseUser;
  LoginCompleteState(this._firebaseUser);

  FirebaseUser getUser(){
    return _firebaseUser;
  }
  @override
  List<Object> get props => [_firebaseUser];
}

class ExceptionState extends LoginState {
  String message;
  ExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class OtpExceptionState extends LoginState {
  String message;
  OtpExceptionState({this.message});

  @override
  List<Object> get props => [message];
}
