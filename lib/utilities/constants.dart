import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firestore = Firestore.instance;//instance of the fire store
final storageRef = FirebaseStorage.instance.ref();//storage reference instance
final usersRef = _firestore.collection('users');//user reference using the fire store collection pointing the collection
final postRef = _firestore.collection('posts');
