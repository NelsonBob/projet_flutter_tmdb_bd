import 'package:dio/dio.dart';
import 'package:movie_db/model/cast_list.dart';
import 'package:movie_db/model/genre.dart';
import 'package:movie_db/model/movie.dart';
import 'package:movie_db/data/env.dart';
import 'package:movie_db/model/movie_image.dart';
import 'package:movie_db/model/person.dart';

import '../model/movie_detail.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Movie>> getDiscoryMovie() async {
    try {
      String url =
          '${Environment.baseUrl}/discover/movie?${Environment.apiKey}';
      final response = await _dio.get(url);
      print(response.data['results']);

      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      print(movieList);
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Genre>> getGenreMovie() async {
    try {
      String url =
          '${Environment.baseUrl}/genre/movie/list?${Environment.apiKey}';

      final response = await _dio.get(url);
      var genres = response.data['genres'] as List;

      List<Genre> genreList = genres.map((m) => Genre.fromJson(m)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getMovieByGenre(int movieId) async {
    try {
      final url =
          '${Environment.baseUrl}/discover/movie?with_genres=$movieId&${Environment.apiKey}';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final response = await _dio
          .get('${Environment.baseUrl}/movie/${movieId}?${Environment.apiKey}');

      MovieDetail movieDetail = MovieDetail.fromJson(response.data);

      movieDetail.trailerId = await getYoutubeId(movieId);

      movieDetail.movieImage = await getMovieImage(movieId);

      movieDetail.castList = await getCastList(movieId);
      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response = await _dio
          .get('${Environment.baseUrl}/movie/$id/videos?${Environment.apiKey}');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      print(error);
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieImage> getMovieImage(int movieId) async {
    try {
      final response = await _dio.get(
          '${Environment.baseUrl}/movie/$movieId/images?${Environment.apiKey}');
      return MovieImage.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Cast>> getCastList(int movieId) async {
    try {
      final response = await _dio.get(
          '${Environment.baseUrl}/movie/${movieId}/credits?${Environment.apiKey}');

      var listCast = response.data['cast'] as List;
      List<Cast> castList = listCast.map((p) => Cast.fromJson(p)).toList();
      print(castList.length);

      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Person>> getTrending() async {
    try {
      final response = await _dio.get(
          '${Environment.baseUrl}/trending/person/week?${Environment.apiKey}');

      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
      return personList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
