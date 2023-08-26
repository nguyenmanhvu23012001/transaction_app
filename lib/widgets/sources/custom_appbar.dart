import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isLiked = false;
  bool _isSearchClicked = false;
  bool _isMenuClicked = false; // To track the menu icon click

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: LikeButton(
        isLiked: _isMenuClicked,
        onTap: (bool isLiked) {
          setState(() {
            _isMenuClicked = !isLiked;
          });
          Navigator.of(context).pop();
          return Future.value(!isLiked);
        },
        likeBuilder: (bool isLiked) {
          return Icon(
            isLiked ? Icons.arrow_back : Icons.arrow_back,
            color: Colors.white,

          );

        },
      ),
      actions: [
        LikeButton(
          isLiked: _isLiked,
          onTap: (bool isLiked) {
            setState(() {
              _isLiked = !isLiked;
            });
            return Future.value(!isLiked);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: LikeButton(
            isLiked: _isSearchClicked,
            onTap: (bool isLiked) {
              setState(() {
                _isSearchClicked = !isLiked;
              });
              return Future.value(!isLiked);
            },
            likeBuilder: (bool isLiked) {
              return Icon(
                isLiked ? Icons.search : Icons.search_outlined,
                color: Colors.white,
              );
            },
          ),
        ),
        LikeButton(
          isLiked: false, // You can set this to true or false based on your requirement
          onTap: (bool isLiked) {
            // Handle the click event for this icon
            return Future.value(!isLiked);
          },
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.more_vert,
              color: Colors.white,
            );
          },
        ),
      ],
      backgroundColor: Colors.black54,
    );

  }
}
