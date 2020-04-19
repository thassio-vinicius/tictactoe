import 'package:flutter/material.dart';

class CrossMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.close,
        size: MediaQuery.of(context).size.width * 0.10,
      ),
    );
  }
}
