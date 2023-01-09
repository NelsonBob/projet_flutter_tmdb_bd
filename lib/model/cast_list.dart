import 'package:flutter/foundation.dart';

class CastList {
  final List<Cast>? cast;

  CastList(this.cast);
}

class Cast {
  final String name;
  final String profilePath;
  final String character;

  Cast(
      {required this.name, required this.profilePath, required this.character});

  factory Cast.fromJson(dynamic json) {
    return Cast(
        name: json['name'] ?? "yo",
        profilePath: json['profile_path'] ?? "yo",
        character: json['character'] ?? "yo");
  }
}
