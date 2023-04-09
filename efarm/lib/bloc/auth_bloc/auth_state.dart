part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  const Uninitialized();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final UserModel user;
  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();

  @override
  List<Object> get props => [];
}

class Loading extends AuthenticationState {
  const Loading();

  @override
  List<Object> get props => [];
}

class Error extends AuthenticationState {
  final AuthErrorModel error;
  const Error(this.error);

  @override
  List<Object> get props => [error];
}
