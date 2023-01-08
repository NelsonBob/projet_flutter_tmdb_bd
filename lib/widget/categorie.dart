// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_db/bloc/genre/genre_event.dart';
// import 'package:movie_db/bloc/genre/genre_state.dart';
// import 'package:movie_db/bloc/moviebloc/movie_bloc.dart';
// import 'package:movie_db/bloc/moviebloc/movie_bloc_state.dart';
// import 'package:movie_db/model/genre.dart';

// import '../bloc/genre/genre_bloc.dart';
// import '../bloc/moviebloc/movie_bloc_event.dart';
// import '../model/movie.dart';
// import '../service/api_service.dart';

// class CategoryMovie extends StatefulWidget {
//   const CategoryMovie({super.key});

//   @override
//   State<CategoryMovie> createState() => _CategoryMovieState();
// }

// class _CategoryMovieState extends State<CategoryMovie> {
//   late int selectedGenre;

//   @override
//   void initState() {
//     super.initState();
//     // selectedGenre = widget.selectedGenre;
//   }

//   @override
//   Widget build(BuildContext conte) {
//     final service = ApiService();

//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<GenreBloc>(
//           create: (_) => GenreBloc(service)..add(LoadGenreEvent()),
//         ),
//         BlocProvider<MovieBloc>(
//           create: (_) => MovieBloc(service)..add(LoadMovieEvent()),
//         ),
//       ],
//       child: _buildGenre(context),
//     );
//   }

//   Widget _buildGenre(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         BlocBuilder<GenreBloc, GenreState>(
//           builder: (context, state) {
//             if (state is GenreLoadingState) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is GenreLoadedState) {
//               List<Genre> genres = state.genre;
//               return Container(
//                 height: 45,
//                 child: ListView.separated(
//                   separatorBuilder: (BuildContext context, int index) =>
//                       VerticalDivider(
//                     color: Colors.transparent,
//                     width: 5,
//                   ),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: genres.length,
//                   itemBuilder: (context, index) {
//                     Genre genre = genres[index];
//                     return Column(
//                       children: <Widget>[
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               Genre genre = genres[index];
//                               selectedGenre = genres[index].id;
//                               // context
//                               //     .read<MovieBloc>()
//                               //     .add(MovieEventStarted(selectedGenre, ''));
//                             });
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.black45,
//                               ),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(25),
//                               ),
//                               color: (genre.id == selectedGenre)
//                                   ? Colors.black45
//                                   : Colors.white,
//                             ),
//                             child: Text(
//                               genre.name.toUpperCase(),
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: (genre.id == selectedGenre)
//                                     ? Colors.white
//                                     : Colors.black45,
//                                 fontFamily: 'muli',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             } else {
//               return Container();
//             }
//           },
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Container(
//           child: Text(
//             'new playing'.toUpperCase(),
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               color: Colors.black45,
//               fontFamily: 'muli',
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         BlocBuilder<MovieBloc, MovieState>(
//           builder: (context, state) {
//             if (state is MovieLoadingState) {
//               return Center();
//             } else if (state is MovieLoadedState) {
//               List<Movie> movieList = state.movie;

//               return Container(
//                 height: 300,
//                 child: ListView.separated(
//                   separatorBuilder: (context, index) => VerticalDivider(
//                     color: Colors.transparent,
//                     width: 15,
//                   ),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: movieList.length,
//                   itemBuilder: (context, index) {
//                     Movie movie = movieList[index];
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         GestureDetector(
//                           onTap: () {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) =>
//                             //        // MovieDetailScreen(movie: movie),
//                             //   ),
//                             // );
//                           },
//                           child: ClipRRect(
//                             child: CachedNetworkImage(
//                               imageUrl:
//                                   'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
//                               imageBuilder: (context, imageProvider) {
//                                 return Container(
//                                   width: 180,
//                                   height: 250,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(12),
//                                     ),
//                                     image: DecorationImage(
//                                       image: imageProvider,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               placeholder: (context, url) => Container(
//                                 width: 180,
//                                 height: 250,
//                                 child: Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) => Container(
//                                 width: 180,
//                                 height: 250,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/img_not_found.jpg'),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: 180,
//                           child: Text(
//                             movie.title.toUpperCase(),
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.black45,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'muli',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 14,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 14,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 14,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 14,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 14,
//                               ),
//                               Text(
//                                 movie.voteAverage,
//                                 style: TextStyle(
//                                   color: Colors.black45,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
