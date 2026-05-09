part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState{}
final class AuthSucces extends AuthState{
  String succesMessage;

  AuthSucces({required this.succesMessage});
}

final class AuthError extends AuthState{
  String errorMessage;
  
  AuthError({required this.errorMessage});
}

