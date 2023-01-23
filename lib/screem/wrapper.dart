import 'package:flutter/cupertino.dart';
import 'package:movie_db/screem/home.dart';
import 'package:provider/provider.dart';
import 'package:movie_db/model/firebaseuser.dart';
import 'package:movie_db/screem/handler.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return Handler();
    } else {
      return const HomeScreem();
    }
  }
}
