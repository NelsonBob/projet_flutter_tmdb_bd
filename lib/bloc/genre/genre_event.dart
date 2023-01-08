import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';



@immutable
abstract class GenreEvent extends Equatable {
  const GenreEvent();
}
//data loading state  
class LoadGenreEvent extends GenreEvent {
  @override
  List<Object> get props => [];
}