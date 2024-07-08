import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// @immutable
// abstract class RegisterEvent extends Equatable {
//   const RegisterEvent();

//   @override
//   List<Object?> get props => [];
// }

// class LoadRegisterEvent extends RegisterEvent {
//   final String fullName;
//   final String email;
//   final String password;

//   const LoadRegisterEvent({
//     required this.fullName,
//     required this.email,
//     required this.password,
//   });

//   @override
//   List<Object?> get props => [fullName, email, password];
// }

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

// ignore: must_be_immutable
class CeroRegisterEvent extends RegisterEvent {
  const CeroRegisterEvent();

  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class LoadRegisterEvent extends RegisterEvent {
  String fullName;
  String email;
  String password;

  LoadRegisterEvent(this.email, this.password, this.fullName);

  @override
  List<Object?> get props => [email, password, fullName];
}

class RegisterButtonPressed extends RegisterEvent {
  final String fullName;
  final String email;
  final String password;

  RegisterButtonPressed({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, password];
}
