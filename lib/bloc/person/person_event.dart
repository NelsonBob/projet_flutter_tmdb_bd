import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class PersonEvent extends Equatable {
  const PersonEvent();
}

//data loading state
class LoadPersonEvent extends PersonEvent {
  final int personId;
  final String query;
  const LoadPersonEvent(this.personId, this.query);
  @override
  List<Object> get props => [];
}
