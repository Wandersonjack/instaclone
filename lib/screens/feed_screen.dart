import 'package:flutter/material.dart';
import 'package:instagrammm/services/auth_service.dart';

class FeedScreen extends StatefulWidget {
  static final String id = 'feed_screen';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Instagram feed'),
            FlatButton(
                color: Colors.white,
                onPressed: () => AuthService.logout(context),
                child: Text("Log out", style: TextStyle(color: Colors.black87)),
            ),
          ],
        ),
      ),
    );
  }
}
