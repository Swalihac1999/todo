part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class LoginSucces extends AuthenticationState {}

class Loginfaild extends AuthenticationState {
  Loginfaild({required this.message});
  String message;
}
