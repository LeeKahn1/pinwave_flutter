part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpClicked extends SignUpEvent {
  final SignUpRequest signUpRequest;

  SignUpClicked({required this.signUpRequest});
}
