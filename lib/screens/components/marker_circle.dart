import 'package:flutter/material.dart';

class CircleMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _size = MediaQuery.of(context).size.width * 0.07;

    return Center(
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 5),
        ),
      ),
    );
  }
}
