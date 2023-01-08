import 'package:dio/dio.dart';
import 'package:movie_db/model/genre.dart';
import 'package:movie_db/model/movie.dart';
import 'package:movie_db/data/env.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Movie>> getDiscoryMovie() async {
    try {
      String url =
          '${Environment.baseUrl}/discover/movie?${Environment.apiKey}';
      print(url);
      final response = await _dio.get(url);

      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Genre>> getGenreMovie() async {
    try {
      String url = '${Environment.baseUrl}/discover/movie?$Environment.apiKey';
      final response = await _dio.get(url);
      var genres = response.data['results'] as List;
      List<Genre> genreList = genres.map((m) => Genre.fromJson(m)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
