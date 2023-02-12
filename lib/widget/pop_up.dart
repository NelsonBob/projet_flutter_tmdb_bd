import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final String title;
  final String content;

  PopUp({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Nom d'acteur: $title"),
                content: Text("Personnage: $content"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: const Text(""),
      ),
    );
  }
}
