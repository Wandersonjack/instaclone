import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Billabong',
            fontSize: 35.0,
          ),
        ),
      ),
    );
  }
}
