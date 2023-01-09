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
        List<Movie> movies;
        if (event.movieId == 0) {
          movies = await service.getDiscoryMovie();
        } else {
          movies = await service.getMovieByGenre(event.movieId);
          print(movies.length);
        }

        emit(MovieLoadedState(movies));
      } catch (e) {
        emit(MovieErrorState(e.toString()));
      }
    });
  }
}
