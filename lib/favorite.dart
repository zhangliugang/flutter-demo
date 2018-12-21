import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() {
    // TODO: implement createState
    return _FavoriteWidgetState();
  }

}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoritedCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoritedCount -= 1;
        _isFavorited = false;
      } else {
        _favoritedCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          child: IconButton(
              icon: _isFavorited ? Icon(Icons.star) : Icon(Icons.star_border),
              color: Colors.red,
              onPressed: _toggleFavorite
          ),
        ),
        SizedBox(
          width: 18.0,
          child: Container(
            child: Text('$_favoritedCount'),
          ),
        )
      ],
    );
  }

}