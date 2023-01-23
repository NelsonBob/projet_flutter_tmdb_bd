import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_db/model/firebaseuser.dart';
import 'package:movie_db/model/like.dart';
import 'package:movie_db/model/login_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  FirebaseUser? _firebaseUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  Future signInEmailPassword(LoginUser _login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _login.email.toString(),
              password: _login.password.toString());
      User? user = userCredential.user;

      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    }
  }

  Future registerEmailPassword(LoginUser _login) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _login.email.toString(),
        password: _login.password.toString(),
      );
      database.ref().child("Users").push().set({
        "username": _login.username.toString(),
        "email": _login.email.toString(),
      });

      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  Map<String, dynamic> createLike(String userId, String postId) {
    return {
      "userId": userId,
      "postId": postId,
    };
  }

  void likePost(String postId) {
    final currentUserId = _auth.currentUser!.uid;
    final like = createLike(currentUserId, postId);
    final likesRef = database.ref().child("Likes");
    likesRef.push().set(like);
  }

//   void likePost(String postId) {
//     final currentUserId = _auth.currentUser!.uid;
//     final likesRef = database.ref().child("Likes");
//     final query = likesRef.orderByChild("userId").equalTo(currentUserId);

//     query.once().then((DataSnapshot snapshot) {
//         if (snapshot.value == null) {
//             // handle case where user does not exist in database
//             final like = createLike(currentUserId, postId);
//             likesRef.push().set(like);
//         } else {
//             // user exists, create like object and push to database
//             if (kDebugMode) {
//               print("User already liked this post.");

//             }}
//     });
// }

// Future<List<Like>> getAllLikes() async {
//     final likesRef = database.ref().child("Likes");
//     final likesSnapshot = await likesRef.once();
//     final likes = likesSnapshot as Map<String, dynamic>;
//     return likes.values.map((like) => Like.fromMap(like)).toList();
// }

  Future<int> getLikeCount(String postId) async {
    final likesRef = database.ref().child("Likes");
    final query = likesRef.orderByChild("postId").equalTo(postId);
    final likesSnapshot = await query.once();
    final likes = likesSnapshot as Map<String, dynamic>;

    return likes.isEmpty ? 0 : likes.length;
  }

  // void unlikePost(String postId) {
  //   final currentUserId = _auth.currentUser!.uid;
  //   final likesRef = database.ref().child("Likes");
  //   likesRef
  //       .orderByChild("userId")
  //       .equalTo(currentUserId)
  //       .once(DatabaseEventType.value)
  //       .then(
  //     (data) {
  //       // value.forEach(
  //       //   (key, value) {
  //       //     if (value['postId'] == postId) {
  //       //       likesRef.child(key).remove();
  //       //     }
  //         },
  //       );
  //       print(data);
  //     },
  //   );
  // }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  countLike(String id, Set<String> set) {}
}
