part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
  const LoginEvent();
}
class SendOtpEvent extends LoginEvent {
  String phoNo;

  SendOtpEvent({this.phoNo});
}

class AppStartEvent extends LoginEvent {}

class VerifyOtpEvent extends LoginEvent {
  String otp;

  VerifyOtpEvent({this.otp});
}

class LogoutEvent extends LoginEvent {}

class OtpSendEvent extends LoginEvent {}

class LoginCompleteEvent extends LoginEvent {
  final FirebaseUser firebaseUser;
  LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends LoginEvent {
  String message;

  LoginExceptionEvent(this.message);
}
