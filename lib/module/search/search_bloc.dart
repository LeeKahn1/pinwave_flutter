import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/pin/search/pin_search_response.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchGetData>((event, emit) async {
      try {
        emit(SearchGetDataLoading());

        Response response = await ApiManager.searchPin(keyword: event.keyword);

        if (response.statusCode == 200) {
          PinSearchResponse pinSearchResponse = PinSearchResponse.fromJson(response.data);

          emit(SearchGetDataSuccess(pinSearchResponse: pinSearchResponse));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(SearchGetDataFinished());
      }
    });
  }
}
