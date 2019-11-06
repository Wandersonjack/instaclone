import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagrammm/models/users_model.dart';
import 'package:instagrammm/screens/default_appbar.dart';
import 'package:instagrammm/screens/edit_profile_screen.dart';
import 'package:instagrammm/utilities/constants.dart';

class ProfileScreen extends StatefulWidget {

  final String userId;//string of the user id that's going to be user in the future userRef document


  ProfileScreen({this.userId});// constructor
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: FutureBuilder(
        future:  usersRef.document(widget.userId).get(), //getting the userRef from factory inside de model accessing via widget
        builder:(BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // collecting the user from the model snapshot data and then replace the mock data with real data coming from firebase
          User user = User.fromDoc(snapshot.data);

          //this list view was wrapped in a future builder and return the list view (child to return)
          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: user.profileImageUrl.isEmpty
                          ? AssetImage('assets/images/placeholder_profile.png')
                          : CachedNetworkImageProvider(user.profileImageUrl),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "400",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Posts",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "900k",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "500",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Following",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 210,
                            child: FlatButton(
                              onPressed: () {
                                /*
                                Using the navigator push with a context and material
                                page route to builder without params
                                pointing to the screen wish to go getting the current user
                                */
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (_) => EditProfileScreen(user: user),
                                ));
                              },
                              child: Text(
                                "Edit profile",
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                        height: 80.0,
                        child: Text(
                          user.bio,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        )),
                    Divider(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
