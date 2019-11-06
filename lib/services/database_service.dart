import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagrammm/models/Post.dart';
import 'package:instagrammm/models/users_model.dart';
import 'package:instagrammm/utilities/constants.dart';

class DatabaseService {
  static void updateUser(User user){
    //going in to the document of the user accessing by id then update
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio' : user.bio,
    });
  }

  //searching for users by name
  static Future<QuerySnapshot> searchUsers(String name){
    Future<QuerySnapshot> users = usersRef.where('name', isGreaterThanOrEqualTo: name ).getDocuments();
    return users;
  }

  static void createPost(Post post){
    postRef.document(post.authorId).collection('usersPost').add({
      'imageUrl' : post.imageUrl,
      'caption' : post.caption,
      'likes' : post.likes,
      'authorId' : post.authorId,
      'timestamp' : post.timestamp,
    });
  }
}