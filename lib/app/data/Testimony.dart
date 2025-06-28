import 'package:cloud_firestore/cloud_firestore.dart';

class Testimony {
  final String id;
  final String userId;
  final String userName;
  final String subscriptionId;
  final String planId;
  final String planName;
  final double rating;
  final String message;
  final DateTime createdAt;
  final bool isApproved;

  Testimony({
    this.id = '',
    required this.userId,
    required this.userName,
    required this.subscriptionId,
    required this.planId,
    required this.planName,
    required this.rating,
    required this.message,
    required this.createdAt,
    this.isApproved = true,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'user_id': userId,
      'user_name': userName,
      'subscription_id': subscriptionId,
      'plan_id': planId,
      'plan_name': planName,
      'rating': rating,
      'message': message,
      'created_at': Timestamp.fromDate(createdAt),
      'is_approved': isApproved,
    };
  }

  factory Testimony.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return Testimony(
      id: doc.id,
      userId: data['user_id']?.toString() ?? '',
      userName: data['user_name']?.toString() ?? 'Anonymous',
      subscriptionId: data['subscription_id']?.toString() ?? '',
      planId: data['plan_id']?.toString() ?? '',
      planName: data['plan_name']?.toString() ?? 'Unknown Plan',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      message: data['message']?.toString() ?? '',
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isApproved: data['is_approved'] as bool? ?? false,
    );
  }
}