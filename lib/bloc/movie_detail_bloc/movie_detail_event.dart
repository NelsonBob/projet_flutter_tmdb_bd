import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

//data loading state
class LoadMovieDetailEvent extends MovieDetailEvent {
  final int id;
  const LoadMovieDetailEvent(this.id);
  @override
  List<Object> get props => [];
}
