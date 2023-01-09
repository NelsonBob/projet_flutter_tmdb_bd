import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/model/genre.dart';
import '../../service/api_service.dart';
import 'genre_event.dart';
import 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final ApiService service;

  GenreBloc(this.service) : super(GenreLoadingState()) {
    on<LoadGenreEvent>((event, emit) async {
      emit(GenreLoadingState());
      try {
        List<Genre> genreList = await service.getGenreMovie();

        emit(GenreLoadedState(genreList));
      } catch (e) {
        emit(GenreErrorState(e.toString()));
      }
    });
  }
}
