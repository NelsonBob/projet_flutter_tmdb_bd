import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarWidget extends StatelessWidget {
  final double sizeStar;

  const StarWidget({super.key, required this.sizeStar});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: sizeStar,
      itemSize: 30,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ignoreGestures: true,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
