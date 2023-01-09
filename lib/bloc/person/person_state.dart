import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_db/model/person.dart';

@immutable
abstract class PersonState extends Equatable {
  const PersonState();
}

//data loading state
class PersonLoadingState extends PersonState {
  @override
  List<Object> get props => [];
}

//data loaded state
class PersonLoadedState extends PersonState {
  const PersonLoadedState(this.personList);
  final List<Person> personList;
  @override
  List<Object> get props => [personList];
}

//data error state
class PersonErrorState extends PersonState {
  const PersonErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [];
}
