import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_db/model/movie_detail.dart';

@immutable
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailLoadingState extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoadedState extends MovieDetailState {
  final MovieDetail detail;

  const MovieDetailLoadedState(this.detail);
  @override
  List<Object> get props => [detail];
}

//data error state
class MovieDetailErrorState extends MovieDetailState {
  const MovieDetailErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [];
}
