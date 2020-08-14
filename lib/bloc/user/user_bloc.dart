import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:soft_bloc/services/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository, super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if(event is CreateUser){
      yield* _mapCreateUserToState(event.fullName);
    }
  }
  Stream<UserState> _mapCreateUserToState(String fullName) async*{
    yield LoadingState();
     try {
       DocumentSnapshot getUserData = await _userRepository.getUserById();
       await _userRepository.createUser(fullName);
       yield CreateUserState(getUserData);
     }catch(e) {
       print("User Add Failed");
     }
  }
}
