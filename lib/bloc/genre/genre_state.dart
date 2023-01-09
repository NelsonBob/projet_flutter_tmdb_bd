import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/genre.dart';

@immutable
abstract class GenreState extends Equatable {
  const GenreState();
}

class GenreLoadingState extends GenreState {
  @override
  List<Object> get props => [];
}

class GenreLoadedState extends GenreState {
  final List<Genre> genreList;

  const GenreLoadedState(this.genreList);
  @override
  List<Object> get props => [genreList];
}

//data error state
class GenreErrorState extends GenreState {
  const GenreErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [];
}
