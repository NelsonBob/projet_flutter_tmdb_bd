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
  const GenreLoadedState(this.genre);
  final List<Genre> genre;
  @override
  List<Object> get props => [];
}

//data error state
class GenreErrorState extends GenreState {
  const GenreErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [];
}
