import 'package:flutter/material.dart';
import 'package:movie_db/service/auth_service.dart';

class PostWidget extends StatefulWidget {
  final String postId;

  const PostWidget({super.key, required this.postId});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isLiked = false;
  int _numberLke = 0;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  final serviceLike = AuthService();

  void _checkIfLiked() async {
    final liked = await serviceLike.isLiked(widget.postId);
    final countLike = await serviceLike.countLikes(widget.postId);
    setState(() {
      _isLiked = liked;
      _numberLke = countLike;
    });
  }

  void _toggleLike() async {
    final liked = await serviceLike.isLiked(widget.postId);
    await serviceLike.likeOrUnlike(widget.postId);
    final countLike = await serviceLike.countLikes(widget.postId);
    if (liked) {
      print("remove like");
      // remove like
    } else {
      // add like
      print("create like");
    }
    setState(() {
      _isLiked = !liked;
      _numberLke = countLike;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.favorite_rounded,
            color: _isLiked ? Colors.red : Colors.black,
          ),
          onPressed: _toggleLike,
        ),
        Text("$_numberLke"),
        // other post content
      ],
    );
  }
}
