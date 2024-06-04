part of 'sign_in_bloc.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInClickedLoading extends SignInState {}

class SignInClickedSuccess extends SignInState {}

class SignInClickedFinished extends SignInState {}
