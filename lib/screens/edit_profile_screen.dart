import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagrammm/models/users_model.dart';
import 'package:instagrammm/services/database_service.dart';
import 'package:instagrammm/services/storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  static final String id = "edit_profile";
  final User user;

  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formkey = GlobalKey<FormState>(); //to validate the text field
  File _profileImage; //this profile image will be picked from image picker
  String _name = '';
  String _bio = '';
  bool _isLoading = false;

  @override
  void initState() {
    //funtion to send the update information to firebase
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery); //source the image is coming from
    if (imageFile != null) {
      //if the image is picked
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage() {
    //No new profile image
    if (_profileImage == null) {
      //no existing profile image
      if (widget.user.profileImageUrl.isEmpty) {
        return AssetImage('assets/images/placeholder_profile.png');
      } else {
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      return FileImage(_profileImage);
    }
  }

  _submit() async {
    if (_formkey.currentState.validate()) {
      //Validating the form with form key
      _formkey.currentState.save(); //saving the current state input information

      setState(() {
        _isLoading = true;
      });

      String _profileImageUrl = ''; //Update user in database

      if (_profileImageUrl == null) {
        _profileImageUrl = widget.user.profileImageUrl;
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
            widget.user.profileImageUrl, _profileImage);
      }

      User user = User(
        id: widget.user.id,
        name: _name,
        profileImageUrl: _profileImageUrl,
        bio: _bio,
      );
      //database update
      DatabaseService.updateUser(user);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit profile',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        // this makes user be able to scroll the screen when the keyboard is up
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Colors.blue[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayProfileImage(),
                      radius: 50.0,
                    ),
                    FlatButton(
                      onPressed:
                          _handleImageFromGallery, //using the handleImageFrom gallery function on the change profile image button
                      child: Text(
                        "Change profile picture",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: _name,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_circle,
                          size: 30.0,
                        ),
                        labelText: 'Name',
                      ),
                      validator: (input) => input.trim().length < 1
                          ? 'Please enter a valid name'
                          : null,
                      onSaved: (input) => _name = input,
                    ),
                    TextFormField(
                      initialValue: _bio,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.book,
                          size: 30.0,
                        ),
                        labelText: 'Bio',
                      ),
                      validator: (input) => input.trim().length > 150
                          ? 'Please enter less than 150 characters'
                          : null,
                      onSaved: (input) => _bio = input,
                    ),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      child: FlatButton(
                        onPressed: _submit,
                        child: Text(
                          "Save profile",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*TODO: important thing to do is enable the access to iOS gallery is opening the iOS in xcode> info.plist and click + to add
      NSPhotolibraryUsageDescription : give access to the user photo library
      NSCameraUsageDescription: give acces to the users camera
      remember to add the description to each
*/
