import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

//data loading state
class LoadMovieEvent extends MovieEvent {
  final int movieId;
  final String query;
  const LoadMovieEvent(this.movieId, this.query);
  @override
  List<Object> get props => [];
}
