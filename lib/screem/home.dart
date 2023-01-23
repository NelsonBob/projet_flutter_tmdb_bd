import 'package:flutter/material.dart';
import 'package:movie_db/service/api_service.dart';
import 'package:movie_db/widget/movie_discover.dart';
import 'package:movie_db/bloc/genre/genre_bloc.dart';
import 'package:movie_db/bloc/genre/genre_event.dart';
import 'package:movie_db/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc_event.dart';
import 'package:movie_db/bloc/person/person_bloc.dart';
import 'package:movie_db/bloc/person/person_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_detail_bloc/movie_detail_event.dart';

class HomeScreem extends StatelessWidget {
  const HomeScreem({super.key});
  static const String routeName = '/homeScreem';

  @override
  Widget build(BuildContext context) {
    final service = ApiService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MovieBloc(service)
            ..add(
              const LoadMovieEvent(0, ''),
            ),
        ),
        BlocProvider(
          create: (_) => PersonBloc(service)
            ..add(
              const LoadPersonEvent(0, ''),
            ),
        ),
        BlocProvider(
          create: (_) => GenreBloc(service)
            ..add(
              LoadGenreEvent(),
            ),
        ),
        BlocProvider(
          create: (_) => MovieDetailBloc(service)
            ..add(
              const LoadMovieDetailEvent(0),
            ),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(
            Icons.menu,
            color: Colors.black54,
          ),
          title: Text(
            'Movie ❤️'.toUpperCase(),
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                right: 15,
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/movie-850.png',
                ),
              ),
            )
          ],
        ),
        body: LoadingBody(context),
      ),
    );
  }
}
