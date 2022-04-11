part of 'root_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unknown,
  unauthenticated,
}

// @immutable
// abstract class RootState {}

class RootState {
  const RootState._({
    required this.status,
    this.user = null,
  });

  const RootState.authenticated(User? user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const RootState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated, user: null);

  const RootState.unknown()
      : this._(status: AuthenticationStatus.unknown, user: null);

  final AuthenticationStatus status;
  final User? user;

  // @override
  // List<Object> get props => [status, user];
}
