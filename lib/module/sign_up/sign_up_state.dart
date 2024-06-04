part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpClickedLoading extends SignUpState {}

class SignUpClickedSuccess extends SignUpState {}

class SignUpClickedFinished extends SignUpState {}
