import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagrammm/models/users_model.dart';
import 'package:instagrammm/services/database_service.dart';

class EditProfileScreen extends StatefulWidget {
  static final String id = "edit_profile";
  final User user;

  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formkey = GlobalKey<FormState>();                                      //to validate the text field
  File _profileImage;                                                           //this profile image will be picked from image picker
  String _name = '';
  String _bio = '';

  @override
  void initState() {                                                            //funtion to send the update information to firebase
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  _handleImageFromGallery () async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);  //source the image is coming from

    if(imageFile!=null){                                                        //if the image is picked
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  /*TODO: important thing to do is enable the access to iOS gallery is opening the iOS in xcode> info.plist and click + to add
      NSPhotolibraryUsageDescription : give access to the user photo library
      NSCameraUsageDescription: give acces to the users camera
      remember to add the description to each
   */

  _submit(){
    if(_formkey.currentState.validate()){                                       //Validating the form with form key
      _formkey.currentState.save();                                             //saving the current state input information


      String _profileImageUrl ='';                                              //Update user in database
      User user = User(
        id: widget.user.id,
        name: _name,
        profileImageUrl: _profileImageUrl,
        bio: _bio,
      );
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
      body: SingleChildScrollView(                                              // this makes user be able to scroll the screen when the keyboard is up
        child: Container(
          height: MediaQuery.of(context).size.height,

          child: Padding(
            padding:  EdgeInsets.all(30.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://uinames.com/api/photos/female/17.jpg")
                    ,
                    radius: 50.0,
                  ),
                  FlatButton(
                    onPressed: _handleImageFromGallery,                         //using the handleImageFrom gallery function on the change profile image button
                    child: Text(
                      "Edit profile picture",
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
                      child: Text("Save profile", style: TextStyle(color: Colors.white),),
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
