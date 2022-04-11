part of 'root_bloc.dart';

abstract class RootEvent extends Equatable {
  const RootEvent();

  @override
  List<Object> get props => [];
}

class RootLogoutRequested extends RootEvent {}

class RootUserFetch extends RootEvent {}

class RootUserChanged extends RootEvent {
  const RootUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
