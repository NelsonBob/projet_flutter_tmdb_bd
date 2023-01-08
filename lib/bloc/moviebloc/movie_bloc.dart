import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc_event.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc_state.dart';
import 'package:movie_db/model/movie.dart';
import 'package:movie_db/service/api_service.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final ApiService service;

  MovieBloc(this.service) : super(MovieLoadingState()) {
    on<LoadMovieEvent>((event, emit) async {
      emit(MovieLoadingState());
      try {
        print("hello");
        List<Movie> movieList = await service.getDiscoryMovie();

        emit(MovieLoadedState(movieList));
      } catch (e) {
        emit(MovieErrorState(e.toString()));
      }
    });
  }
}
