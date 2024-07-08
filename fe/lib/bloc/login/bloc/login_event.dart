import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  
}

// ignore: must_be_immutable
class CeroLoginEvent extends LoginEvent {


  const CeroLoginEvent();

  @override


  List<Object?> get props => [];
}


// ignore: must_be_immutable
class LoadLoginEvent extends LoginEvent {

  String email;
  String password;

  LoadLoginEvent(this.email,this.password);

  @override


  List<Object?> get props => [email,password];
}