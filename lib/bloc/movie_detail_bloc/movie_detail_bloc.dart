import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:movie_db/bloc/movie_detail_bloc/movie_detail_state.dart';
import '../../service/api_service.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final ApiService service;

  MovieDetailBloc(this.service) : super(MovieDetailLoadingState()) {
    on<LoadMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoadingState());
      try {
        final movieDetail = await service.getMovieDetail(event.id);
        print(movieDetail);

        emit(MovieDetailLoadedState(movieDetail));
      } catch (e) {
        emit(MovieDetailErrorState(e.toString()));
      }
    });
  }
}
