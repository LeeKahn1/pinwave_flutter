part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeGetDataLoading extends HomeState {}

class HomeGetDataSuccess extends HomeState {
  final HomePinResponse homePinResponse;

  HomeGetDataSuccess({required this.homePinResponse});
}

class HomeGetDataFinished extends HomeState {}
