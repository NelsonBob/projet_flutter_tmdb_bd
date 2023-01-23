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
        id: json['id'].toString() ?? "loading",
        title: json['title'] ?? "loading",
        backdropPath: json['backdrop_path'] ?? "loading",
        budget: json['budget'].toString() ?? "loading",
        homePage: json['home_page'] ?? "loading",
        originalTitle: json['original_title'] ?? "loading",
        overview: json['overview'] ?? "loading",
        releaseDate: json['release_date'] ?? "2022-03-03",
        runtime: json['runtime'].toString() ?? "loading",
        voteAverage: json['vote_average'].toString() ?? "loading",
        voteCount: json['vote_count'].toString() ?? "loading");
  }
}
