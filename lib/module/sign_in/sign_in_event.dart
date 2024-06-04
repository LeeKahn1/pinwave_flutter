part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInClick extends SignInEvent {
  final SignInRequest signInRequest;

  SignInClick({required this.signInRequest});
}
