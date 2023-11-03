import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  Future<bool> publishPost(date, description, category, image, address) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      final id = const Uuid().v4();
      await _firestore
          .collection('categories')
          .doc(category)
          .collection('posts')
          .doc(id)
          .set({
        'date': date,
        'description': description,
        'downvotes': 0,
        'upvotes': 0,
        'reported': false,
        'user': "sadio",
        'image': image,
        'address': address,
        //'location': location,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
