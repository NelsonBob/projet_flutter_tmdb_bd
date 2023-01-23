import 'package:flutter/material.dart';
import 'package:movie_db/screem/Login.dart';
import 'package:movie_db/screem/home.dart';
import 'package:movie_db/screem/screen_not_found.dart';
import 'package:movie_db/screem/wrapper.dart';

class MyRouter {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      '/': (BuildContext context) => Wrapper(),
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
