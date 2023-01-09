import 'package:movie_db/model/cast_list.dart';
import 'package:movie_db/model/movie_image.dart';

class MovieDetail {
  final String id;
  final String title;
  final String backdropPath;
  final String budget;
  final String homePage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String runtime;
  final String voteAverage;
  final String voteCount;

  late String trailerId;

  late MovieImage movieImage;

  late List<Cast> castList;

  MovieDetail({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.budget,
    required this.homePage,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(dynamic json) {
    return MovieDetail(
        id: json['id'].toString() ?? "yo",
        title: json['title'] ?? "yo",
        backdropPath: json['backdrop_path'] ?? "yo",
        budget: json['budget'].toString() ?? "yo",
        homePage: json['home_page'] ?? "yo",
        originalTitle: json['original_title'] ?? "yo",
        overview: json['overview'] ?? "yo",
        releaseDate: json['release_date'] ?? "2022-03-03",
        runtime: json['runtime'].toString() ?? "yo",
        voteAverage: json['vote_average'].toString() ?? "yo",
        voteCount: json['vote_count'].toString() ?? "yo");
  }
}
