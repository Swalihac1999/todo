// ignore_for_file: must_be_immutable, avoid_multiple_declarations_per_line

part of 'creation_bloc.dart';

@immutable
abstract class CreationEvent {}

class SignEvent extends CreationEvent {
  SignEvent({
    required this.email,
    required this.fistnme,
    required this.secondname,
    required this.phone,
    required this.password,
  });
  String email;
  String password;
  String fistnme;
  String secondname;
  String phone;
}
