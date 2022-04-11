import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:user_repository/user_repository.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(RootState.unknown()) {
    on<RootUserChanged>(_onUserChanged);
    on<RootUserFetch>(_onUserFetch);
    on<RootLogoutRequested>(_onLogoutRequested);

    _userSubscription = _authenticationRepository.user.listen((data) {
      print(data);
    });
  }

  void _onUserChanged(RootUserChanged event, Emitter<RootState> emit) {
    emit(
      event.user != null
          ? RootState.authenticated(event.user)
          : const RootState.unauthenticated(),
    );
  }

  void _onLogoutRequested(RootLogoutRequested event, Emitter<RootState> emit) {
    unawaited(_authenticationRepository.signOut());
  }

  final UserRepository _userRepository = UserRepository();
  void _onUserFetch(RootUserFetch event, Emitter<RootState> emit) async {
    String? id = await _authenticationRepository.getCurrentUser();
    if (id == null) {
      emit(RootState.unauthenticated());
    } else {
      try {
        var user = await _userRepository.getUserData(uid: id);
        emit(RootState.authenticated(user));
        globals.currentUserData = user as User;
      } catch (e) {
        emit(RootState.unauthenticated());
      }
    }
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User?> _userSubscription;
}
