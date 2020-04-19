import 'package:flutter/cupertino.dart';

class TicTacButton {
  final id;
  Widget marker;
  bool enabled;

  TicTacButton({this.id, this.enabled = true, this.marker});
}
