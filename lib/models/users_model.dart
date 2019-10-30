import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final String bio;

  User({
    this.id,
    this.name,
    this.email,
    this.profileImageUrl,
    this.bio
  }); //constructor

  //accessing the user document via factory
  factory User.fromDoc(DocumentSnapshot doc) {
    //note: the names has to be just like whats being used in firebase
    return User(
      id: doc.documentID,
      name: doc['name'],
      email: doc['email'],
      profileImageUrl: doc['profileImageUrl'],
      bio: doc['bio'] ??
          '', //?? to check if the bio has info if not return an empty string
    );
  }
}
