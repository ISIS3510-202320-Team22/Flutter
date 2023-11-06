import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guarap/components/publish_photos/model/user_model.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  Future<String> publishPost(
      date, description, category, image, address) async {
    try {
      // TODO: Check user session is still valid before publishing
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final postId = const Uuid().v4();
      // Get the current user's uuid
      final uuid = FirebaseAuth.instance.currentUser!.uid;
      // Get the document reference
      final userDocRef = firestore.collection('users').doc(uuid).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, _) => user.toFirestore());
      final userDocSnap = await userDocRef.get();
      final user = userDocSnap.data(); // Convert to UserModel
      if (user == null) {
        return "User not found";
      }
      final username = user.username;
      await firestore
          .collection('categories')
          .doc(category)
          .collection('posts')
          .doc(postId)
          .set({
        'date': date,
        'description': description,
        'downvotes': 0,
        'upvotes': 0,
        'reported': false,
        'user': username,
        'image': image,
        'address': address,
        //'location': location,
      });
      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
