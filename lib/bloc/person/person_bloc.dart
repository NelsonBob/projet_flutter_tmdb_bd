import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/bloc/person/person_event.dart';
import 'package:movie_db/bloc/person/person_state.dart';
import 'package:movie_db/model/person.dart';
import 'package:movie_db/service/api_service.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final ApiService service;

  PersonBloc(this.service) : super(PersonLoadingState()) {
    on<LoadPersonEvent>((event, emit) async {
      emit(PersonLoadingState());
      try {
        List<Person> personList = await service.getTrending();

        emit(PersonLoadedState(personList));
      } catch (e) {
        emit(PersonErrorState(e.toString()));
      }
    });
  }
}
