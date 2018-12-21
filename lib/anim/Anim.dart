import 'package:flutter/material.dart';

class AnimPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimPageState();

}

class _AnimPageState extends State<AnimPage> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Center(
        child: AnimatedOpacity(
            opacity: _visible ? 1.0: 0.0,
            duration: Duration(milliseconds: 500),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.flip),
      ),
    );
  }

}