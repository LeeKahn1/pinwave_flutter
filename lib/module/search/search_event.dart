part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchGetData extends SearchEvent {
  final String keyword;

  SearchGetData({required this.keyword});
}
