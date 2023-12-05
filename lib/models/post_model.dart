import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? id;
  final String? user;
  final String? address;
  final String? description;
  final String? image;
  final Timestamp? date;
  final bool? reported;
  final int? upvotes;
  final int? downvotes;

  PostModel({
    this.id,
    this.user,
    this.address,
    this.description,
    this.image,
    this.date,
    this.reported,
    this.upvotes,
    this.downvotes,
  });

  factory PostModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PostModel(
      id: snapshot.id,
      user: data?['user'],
      address: data?['address'],
      description: data?['description'],
      image: data?['image'],
      date: data?['date'],
      reported: data?['reported'],
      upvotes: data?['upvotes'],
      downvotes: data?['downvotes'],
    );
  }

  factory PostModel.fromDocument(QueryDocumentSnapshot doc) {
    return PostModel(
      id: doc.id,
      user: doc['user'],
      address: doc['address'],
      description: doc['description'],
      image: doc['image'],
      date: doc['date'],
      reported: doc['reported'],
      upvotes: doc['upvotes'],
      downvotes: doc['downvotes'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (user != null) 'user': user,
      if (address != null) 'address': address,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
      if (date != null) 'date': date,
      if (reported != null) 'reported': reported,
      if (upvotes != null) 'upvotes': upvotes,
      if (downvotes != null) 'downvotes': downvotes,
    };
  }
}
