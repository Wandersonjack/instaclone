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
}