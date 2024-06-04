part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchGetDataLoading extends SearchState {}

class SearchGetDataSuccess extends SearchState {
  final PinSearchResponse pinSearchResponse;

  SearchGetDataSuccess({required this.pinSearchResponse});
}

class SearchGetDataFinished extends SearchState {}
