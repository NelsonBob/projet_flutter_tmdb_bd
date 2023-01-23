import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc.dart';
import 'package:movie_db/bloc/moviebloc/movie_bloc_state.dart';
import 'package:movie_db/bloc/person/person_bloc.dart';
import 'package:movie_db/bloc/person/person_state.dart';
import 'package:movie_db/model/movie.dart';
import 'package:movie_db/model/person.dart';
import 'package:movie_db/widget/movie_detail_screen.dart';

import 'categorie.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieLoadedState) {
                      List<Movie> movies = state.movie;
                      return Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: movies.length,
                            itemBuilder: (BuildContext context, int index,
                                int pageViewIndex) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                        movie: movies[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${movies[index].backdropPath}',
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/not_found.jpg'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        bottom: 15,
                                      ),
                                      child: Text(
                                        movies[index].title.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'muli',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              pauseAutoPlayOnTouch: true,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Column(
                              children: <Widget>[
                                const CategoryMovie(),
                                Text(
                                  'Trending persons on this week'.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                    fontFamily: 'muli',
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  children: <Widget>[
                                    BlocBuilder<PersonBloc, PersonState>(
                                      builder: (context, state) {
                                        if (state is PersonLoadingState) {
                                          return const Center();
                                        } else if (state is PersonLoadedState) {
                                          List<Person> personList =
                                              state.personList;
                                          return Container(
                                            height: 110,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: personList.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const VerticalDivider(
                                                color: Colors.transparent,
                                                width: 5,
                                              ),
                                              itemBuilder: (context, index) {
                                                Person person =
                                                    personList[index];
                                                return Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        elevation: 3,
                                                        child: ClipRRect(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                'https://image.tmdb.org/t/p/w200${person.profilePath}',
                                                            imageBuilder: (context,
                                                                imageProvider) {
                                                              return Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            100),
                                                                  ),
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            placeholder: (context,
                                                                    url) =>
                                                                const SizedBox(
                                                              width: 80,
                                                              height: 80,
                                                              child: Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(
                                                              width: 80,
                                                              height: 80,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/not_found.png'),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          person.name
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 8,
                                                            fontFamily: 'muli',
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          person
                                                              .knowForDepartment
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 8,
                                                            fontFamily: 'muli',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text("something went wrong");
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
