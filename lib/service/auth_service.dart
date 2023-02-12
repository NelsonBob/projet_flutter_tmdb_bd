import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:movie_db/model/firebaseuser.dart';
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

  Future<void> likeOrUnlike(String postId) async {
    final currentUserId = _auth.currentUser!.uid;

    bool isCurrentlyLiked = await isLiked(postId);
    if (isCurrentlyLiked) {
      await database
          .ref()
          .child('Likes')
          .child(postId)
          .child(currentUserId)
          .remove();
    } else {
      await database
          .ref()
          .child('Likes')
          .child(postId)
          .child(currentUserId)
          .set(true);
    }
  }

  Future<int> countLikes(String postId) async {
    final DataSnapshot snapshot = await FirebaseDatabase.instance
        .ref()
        .child('Likes')
        .child(postId)
        .get();
    return snapshot.children.length;
  }

  Future<bool> isLiked(String postId) async {
    final currentUserId = _auth.currentUser!.uid;
    final DataSnapshot snapshot = await FirebaseDatabase.instance
        .ref()
        .child('Likes')
        .child(postId)
        .child(currentUserId)
        .get();
    if (snapshot.value != null) {
      return true;
    }
    return false;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
