import 'package:flutter/material.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc_event.dart';
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
      home: BlocProvider(
        create: (_) => MovieBloc(service)..add(LoadMovieEvent()),
        child: const HomeScreem(),
      ),
    );
  }
}
