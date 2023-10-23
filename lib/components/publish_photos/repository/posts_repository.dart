import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guarap/components/publish_photos/repository/storage_methods.dart';

class PostRepository {
  Future<bool> publishPost(date, description, downvotes, upvotes, image,
      location, reported, postId, category) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', image, true);
      await _firestore
          .collection('categories')
          .doc(category)
          .collection('posts')
          .doc(postId)
          .set({
        'date': date,
        'description': description,
        'downvotes': downvotes,
        'upvotes': upvotes,
        'image': photoUrl,
        'location': location,
        'reported': reported,
        'user': postId,
        'category': category,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
