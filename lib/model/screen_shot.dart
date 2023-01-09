import 'package:equatable/equatable.dart';

class Screenshot extends Equatable {
  final String aspect;
  final String imagePath;
  final int height;
  final int width;
  final String countryCode;
  final String voteAverage;
  final int voteCount;

  const Screenshot(
      {required this.aspect,
      required this.imagePath,
      required this.height,
      required this.width,
      required this.countryCode,
      required this.voteAverage,
      required this.voteCount});

  factory Screenshot.fromJson(Map<String, dynamic> json) {
    return Screenshot(
        aspect: json['aspect_ratio'].toString() ?? "yo",
        imagePath: json['file_path'] ?? "yo",
        height: json['height'] ?? 3,
        width: json['width'] ?? 3,
        countryCode: json['iso_639_1'] ?? "yo",
        voteAverage: json['vote_average'].toString() ?? "yo",
        voteCount: json['vote_count'] ?? "yo");
  }

  @override
  List<Object> get props =>
      [aspect, imagePath, height, width, countryCode, voteAverage, voteCount];
}
