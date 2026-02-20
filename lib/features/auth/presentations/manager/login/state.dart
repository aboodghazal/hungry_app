

import '../../../domain/entity/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class LogoutLoading extends AuthState {}
class UpdateProfileLoading extends AuthState {}
class UpdateProfileSuccess extends AuthState {
  final String message;
  UpdateProfileSuccess(this.message);
}
class LogoutSuccess extends AuthState {
  final String message;

  LogoutSuccess(this.message);
}

class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
