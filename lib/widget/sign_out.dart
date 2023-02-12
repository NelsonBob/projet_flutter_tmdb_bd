import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_db/service/auth_service.dart';

class SignOutButton extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  final serviceOut = AuthService();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () async {
        await serviceOut.signOut();
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );
  }
}
