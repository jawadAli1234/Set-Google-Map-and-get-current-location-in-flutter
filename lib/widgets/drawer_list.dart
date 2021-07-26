import 'package:flutter/material.dart';

class DrawerTiles extends StatelessWidget {
  final String text;
  final Icon icons;

  DrawerTiles(
    this.text,
    this.icons,
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icons,
      title: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
