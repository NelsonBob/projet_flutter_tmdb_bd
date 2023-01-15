import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/model/cast_list.dart';
import 'package:movie_db/model/movie.dart';
import 'package:movie_db/model/movie_detail.dart';
import 'package:movie_db/model/screen_shot.dart';
import 'package:movie_db/service/api_service.dart';
import 'package:movie_db/widget/starwidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/movie_detail_bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_bloc/movie_detail_event.dart';
import '../bloc/movie_detail_bloc/movie_detail_state.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final service = ApiService();

    return BlocProvider(
      create: (_) =>
          MovieDetailBloc(service)..add(LoadMovieDetailEvent(movie.id)),
      child: WillPopScope(
        child: Scaffold(
          body: _buildDetailBody(context),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Widget _buildDetailBody(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailLoadedState) {
          MovieDetail movieDetail = state.detail;
          return Stack(
            children: <Widget>[
              ClipPath(
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/img_not_found.jpg'),
                        ),
                      ),
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 180),
                    child: GestureDetector(
                      onTap: () async {
                        final youtubeUrl =
                            'https://www.youtube.com/embed/${movieDetail.trailerId}';
                        // ignore: deprecated_member_use
                        if (await canLaunch(youtubeUrl)) {
                          // ignore: deprecated_member_use
                          await launch(youtubeUrl);
                        }
                      },
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            const Icon(
                              Icons.play_circle_outline,
                              color: Colors.yellow,
                              size: 65,
                            ),
                            Text(
                              movieDetail.title.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'muli',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  StarWidget(
                    sizeStar: double.parse(movieDetail.voteAverage) / 2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Overview'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 35,
                          child: Text(
                            movieDetail.overview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontFamily: 'muli'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Release date'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                      ),
                                ),
                                Text(
                                  movieDetail.releaseDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color: Colors.yellow[800],
                                        fontSize: 12,
                                        fontFamily: 'muli',
                                      ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'run time'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                      ),
                                ),
                                Text(
                                  movieDetail.runtime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: Colors.yellow[800],
                                        fontSize: 12,
                                        fontFamily: 'muli',
                                      ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'budget'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                      ),
                                ),
                                Text(
                                  movieDetail.budget,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color: Colors.yellow[800],
                                        fontSize: 12,
                                        fontFamily: 'muli',
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Screenshots'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'muli',
                              ),
                        ),
                        Container(
                          height: 120,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: movieDetail.movieImage.backdrops.length,
                            itemBuilder: (context, index) {
                              Screenshot image =
                                  movieDetail.movieImage.backdrops[index];
                              return Card(
                                elevation: 3,
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${image.imagePath}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Casts'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'muli',
                              ),
                        ),
                        SizedBox(
                          height: 110,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const VerticalDivider(
                              color: Colors.transparent,
                              width: 6,
                            ),
                            itemCount: movieDetail.castList.length,
                            itemBuilder: (context, index) {
                              Cast cast = movieDetail.castList[index];
                              return Column(
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    elevation: 3,
                                    child: ClipRRect(
                                      child: cast.profilePath.isEmpty
                                          ? Container(
                                              width: 80,
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/person_icon-icons.com_50075.png'),
                                                ),
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                                              imageBuilder:
                                                  (context, imageBuilder) {
                                                return Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    image: DecorationImage(
                                                      image: imageBuilder,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                              placeholder: (context, url) =>
                                                  const SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                width: 80,
                                                height: 80,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/not_found.png'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        cast.name.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 8,
                                          fontFamily: 'muli',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        cast.character.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 8,
                                          fontFamily: 'muli',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
