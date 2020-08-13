import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:soft_bloc/services/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc(this.userRepository) : super(AuthInitial());

  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.getUser() != null;

      if (hasToken) {
        DocumentSnapshot getUserData = await userRepository.getUserById();
        yield Authenticated(getUserData);
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }

    if (event is LoggedOut) {
      yield Loading();
      yield Unauthenticated();
      userRepository.signOut();
    }

    if(event is CheckPermanentUser){
      yield* _mapPermanentCheckToState();
    }
  }
  Stream<AuthState> _mapLoggedInToState()async*{
    DocumentSnapshot getUserData = await userRepository.getUserById();
    DateTime startTime = DateTime.parse(getUserData.data['startDate']);
    DateTime endTime = DateTime.now();
    int differenceDay = endTime.difference(startTime).inMinutes;

    if(differenceDay > getUserData.data['limitDate']){
      if( getUserData.data['limitDate'] == 1){
        yield WarningFreeUser();
      }else{
        yield WarningPermanentUser();
      }
    }
    yield Authenticated(getUserData);
  }

  Stream<AuthState> _mapPermanentCheckToState()async*{
    final bool hasToken = await userRepository.getUser() != null;
    if(hasToken){
      DocumentSnapshot getUserData = await userRepository.getUserById();

      DateTime startTime = DateTime.parse(getUserData.data['startDate']);
      DateTime endTime = DateTime.now();
      int differenceDay = endTime.difference(startTime).inMinutes;

      if(differenceDay > getUserData.data['limitDate']){
        if( getUserData.data['limitDate'] == 1){
          yield WarningFreeUser();
        }else{
          yield WarningPermanentUser();
        }
      }
      yield Authenticated(getUserData);
    }else{
      yield Unauthenticated();
    }
  }
}
