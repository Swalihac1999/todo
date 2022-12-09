part of 'creation_bloc.dart';

@immutable
abstract class CreationState {}

class CreationInitial extends CreationState {}

class SignUpSucces extends CreationState {}

class SignUpFailed extends CreationState {
  SignUpFailed({required this.message});

  String message;
}
