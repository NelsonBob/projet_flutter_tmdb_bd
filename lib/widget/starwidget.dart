import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarWidget extends StatefulWidget {
  final double sizeStar;
  const StarWidget({super.key, required this.sizeStar});

  @override
  State<StarWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: widget.sizeStar,
      itemSize: 15,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 9,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
