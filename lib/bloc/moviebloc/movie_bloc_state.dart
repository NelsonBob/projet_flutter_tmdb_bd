import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_db/model/movie.dart';

// abstract class MovieState extends Equatable {
//   const MovieState();

//   @override
//   List<Object> get props => [];
// }

// class MovieLoading extends MovieState {}

// class MovieLoaded extends MovieState {
//   final List<Movie> movieList;
//   const MovieLoaded(this.movieList);

//   @override
//   List<Object> get props => [movieList];
// }

// class MovieError extends MovieState {}

@immutable
abstract class MovieState extends Equatable {
  const MovieState();
}

//data loading state
class MovieLoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

//data loaded state
class MovieLoadedState extends MovieState {
  const MovieLoadedState(this.movie);
  final List<Movie> movie;
  @override
  List<Object> get props => [];
}

//data error state
class MovieErrorState extends MovieState {
  const MovieErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [];
}
