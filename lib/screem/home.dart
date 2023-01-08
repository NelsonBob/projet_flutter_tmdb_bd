import 'package:flutter/material.dart';
import 'package:movie_db/widget/moviediscover.dart';

class HomeScreem extends StatelessWidget {
  const HomeScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black54,
        ),
        title: Text(
          'Movie ❤️'.toUpperCase(),
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 15,
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/movie-850.png',
              ),
            ),
          )
        ],
      ),
      body: LoadingBody(context),
    );
  }
}
