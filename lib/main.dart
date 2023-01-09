import 'package:flutter/material.dart';
import 'package:movie_db/bloc/genre/genre_bloc.dart';
import 'package:movie_db/bloc/genre/genre_event.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc_event.dart';
import 'package:movie_db/bloc/person/person_bloc.dart';
import 'package:movie_db/bloc/person/person_event.dart';
import 'package:movie_db/screem/home.dart';
import 'package:movie_db/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ApiService();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => MovieBloc(service)..add(const LoadMovieEvent(0, '')),
          ),
          BlocProvider(
            create: (_) =>
                PersonBloc(service)..add(const LoadPersonEvent(0, '')),
          ),
          BlocProvider(
            create: (_) => GenreBloc(service)..add(LoadGenreEvent()),
          ),
        ],
        child: const HomeScreem(),
      ),
    );
  }
}



