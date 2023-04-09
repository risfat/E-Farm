part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  const AppStarted();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  const LoggedIn({required this.token});

  @override
  List<Object> get props => [token];
}

class RegisterUser extends AuthenticationEvent {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String address;
  final String type;

  const RegisterUser({required this.name, required this.phone, required this.email, required this.password, required this.address, required this.type});

  @override
  List<Object> get props => [name, phone, email, password, address, type];
}

class LoggedOut extends AuthenticationEvent {
  const LoggedOut();

  @override
  List<Object> get props => [];
}
