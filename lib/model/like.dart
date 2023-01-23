import 'package:firebase_database/firebase_database.dart';

class Like {
  final String userId;
  final String postId;
  Like({required this.userId, required this.postId});

  factory Like.fromMap(Map<String, dynamic> data) {
    return Like(
      userId: data['userId'],
      postId: data['postId'],
    );
  }

  factory Like.fromSnapshot(DataSnapshot snapshot) {
    return Like.fromMap(snapshot.value as Map<String, dynamic>);
  }
}
