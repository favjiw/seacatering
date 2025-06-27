import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionData {
  final String name;
  final String phone;
  final String selectedPlan;
  final String selectedPlanId;
  final List<String> selectedMeals;
  final List<String> selectedDeliveryDays;
  final String allergies;
  final String additionalRequest;
  final bool isReactivated;
  final int reactivateCount;
  final DateTime? startDate;
  final DateTime? endDate;

  SubscriptionData({
    required this.name,
    required this.phone,
    required this.selectedPlan,
    required this.selectedPlanId,
    required this.selectedMeals,
    required this.selectedDeliveryDays,
    required this.allergies,
    required this.additionalRequest,
    this.isReactivated = false,
    this.reactivateCount = 0,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toFirestoreMap() {
    final now = DateTime.now();
    return {
      'user_name': name,
      'phone_number': phone,
      'plan_name': selectedPlan,
      'plan_id': selectedPlanId,
      'meal_type': selectedMeals,
      'delivery_days': selectedDeliveryDays,
      'allergies': allergies,
      'additional_request': additionalRequest,
      'status': 'ACTIVE',
      'start_date': Timestamp.fromDate(startDate ?? now),
      'end_date': Timestamp.fromDate(endDate ?? now.add(Duration(days: 30))),
      'is_reactivated': isReactivated,
      'reactivate_count': reactivateCount,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}