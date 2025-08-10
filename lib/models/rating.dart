import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  final String userId;
  final int rating;
  final String feedback;
  final DateTime createdAt;

  Rating({
    required this.userId,
    required this.rating,
    required this.feedback,
    required this.createdAt,
  });

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] ?? '',
      rating: map['rating'] ?? 0,
      feedback: map['feedback'] ?? '',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'feedback': feedback,
      'createdAt': createdAt,
    };
  }
}
