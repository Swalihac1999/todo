part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent{
LoginEvent({required this.email,required this.password});
String email;
String password;
}
