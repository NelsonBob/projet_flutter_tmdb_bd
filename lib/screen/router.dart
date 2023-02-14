import 'package:flutter/material.dart';
import 'package:movie_db/screen/Login.dart';
import 'package:movie_db/screen/home.dart';
import 'package:movie_db/screen/screen_not_found.dart';
import 'package:movie_db/screen/wrapper.dart';

import '../widget/check_connexion.dart';

class MyRouter {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      '/': (BuildContext context) => CheckConnexion(),
      HomeScreem.routeName: (BuildContext context) => const HomeScreem(),
      Login.routeName: (BuildContext context) => const Login(),
    };
  }

  static MaterialPageRoute getRouter(RouteSettings settings) {
    Widget screen = const ScreenNotFound();

    // switch (settings.name) {
    //   case ScreenC.routeName:
    //     final arguments = settings.arguments;
    //     if (arguments is int) {
    //       screen = ScreenC(id: arguments);
    //     }
    //     break;
    // }

    return MaterialPageRoute(builder: (context) => screen);
  }
}
