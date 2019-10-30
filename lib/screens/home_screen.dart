import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagrammm/screens/activity_screen.dart';
import 'package:instagrammm/screens/create_post_screen.dart';
import 'package:instagrammm/screens/feed_screen.dart';
import 'package:instagrammm/screens/profile_screen.dart';
import 'package:instagrammm/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
   static final String id = "home_screen";

   final String userId;                                                         //attributo user id instanciado
   HomeScreen({this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0; //instance of the current tab starting at zero
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

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

      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedScreen(),
          SearchScreen(),
          CreatePostScreen(),
          ActivityScreen(),
          ProfileScreen(userId: widget.userId),
        ],
        onPageChanged: (int index){
          setState(() {
            _currentTab = index;
          });
        },
      ),

      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab, //collecting the current state by the index
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeIn,
          );
        },
        activeColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
