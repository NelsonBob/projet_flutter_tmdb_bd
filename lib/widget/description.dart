import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/model/movie.dart';
import 'package:movie_db/model/movie_detail.dart';
import 'package:movie_db/widget/change_text.dart';
import 'package:movie_db/widget/starwidget.dart';

class DescriptionMovie extends StatelessWidget {
  final Movie movieDetail;
  const DescriptionMovie({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: StarWidget(
                      sizeStar: double.parse(movieDetail.voteAverage),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: change_text(
                text: movieDetail.title,
                color: Colors.white,
                size: 24,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: change_text(
                text: 'Releasing On - ${movieDetail.releaseDate}',
                color: Colors.white,
                size: 14,
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/not_found.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                    child: change_text(
                  text: movieDetail.overview,
                  color: Colors.white,
                  size: 18,
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
