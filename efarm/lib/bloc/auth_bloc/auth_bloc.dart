
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/auth_error_model.dart';
import '../../models/user_model.dart';
import '../../repositories/repository.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository _repository;

  AuthenticationBloc({required Repository userRepository})
      : _repository = userRepository, super(const Unauthenticated()){
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<RegisterUser>(_onRegisterUser);
  }

  // AuthenticationState get initialState => const Uninitialized();

  _onAppStarted(AppStarted event, Emitter<AuthenticationState> emit) async {
    emit(const Loading());
    // print("===============================App Started=================================");
    final String token = await _repository.getToken();
    if (token != "") {
      final UserModel? user = await _repository.getUser(token);
      if (user != null) {
        await _repository.setLoggedInStatus(true);
        return emit(Authenticated(user));
      }else {
        await _repository.setLoggedInStatus(false);
        return emit(const Unauthenticated());
      }
    } else {
      await _repository.setLoggedInStatus(false);
      return emit(const Unauthenticated());
    }
  }

  _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    // _userRepository.persistToken(event.token);
    // print("==============================_onLoggedIn==================================");
    final UserModel? user = await _repository.getUser(event.token);
    if (user != null) {
      await _repository.setLoggedInStatus(true);
      return emit(Authenticated(user));
    }else {
      await _repository.setLoggedInStatus(false);
      emit(const Unauthenticated());
    }
  }

  _onRegisterUser(RegisterUser event, Emitter<AuthenticationState> emit) async {
    // _userRepository.persistToken(event.token);
    // print("==============================_onRegistered==================================");
    emit(const Loading());
    final result = await _repository.registerUser(email: event.email, phone: event.phone, name: event.name, password: event.password, address: event.address, type: event.type);
    if (result != null) {
      if (!result['hasError']) {
        await _repository.setLoggedInStatus(true);
        return emit(Authenticated(result['user']));
      }else {
        return emit(Error(result['error']));
      }
    } else {
      return emit(const Unauthenticated());
    }

  }

  _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    // print("==============================_onLoggedOut==================================");
    final bool success = await _repository.deleteToken();
    if (success) {
      await _repository.setLoggedInStatus(false);
      return emit(const Unauthenticated());
    }
  }

}
