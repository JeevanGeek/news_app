import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late NewsAPI api;
  late News news;

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      api = NewsAPI();

      if (event is GetQueryNews) {
        emit(const SearchNewsLoading());
        try {
          news = await api.getQueryNews(event.query);
          news.totalResults == 0
              ? emit(const SearchNewsEmpty())
              : emit(SearchNewsLoaded(news));
        } catch (e) {
          emit(const SearchNewsError());
        }
      }
    });
  }
}
