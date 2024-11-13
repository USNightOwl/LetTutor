import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class EmailInvalid extends SignInState {
  final String error;

  EmailInvalid(this.error);

  @override
  List<Object> get props => [error];
}

class EmailValid extends SignInState {
  @override
  List<Object> get props => [];
}
