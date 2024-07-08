import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fe/data/model/users_model.dart';
import 'package:fe/data/model/users_model.dart';

@immutable
abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterSuccessState extends RegisterState {
  final UserModel? user; // Jadikan UserModel menjadi nullable dengan menambahkan tanda tanya (?)

  RegisterSuccessState([this.user]); // Jadikan argumen user menjadi opsional

  @override
  List<Object?> get props => [user];
}


class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
