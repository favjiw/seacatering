class SubscriptionData {
  final String name;
  final String phone;
  final String selectedPlan;
  final String selectedPlanId;
  final List<String> selectedMeals;
  final List<String> selectedDeliveryDays;
  final String allergies;
  final String additionalRequest;

  SubscriptionData({
    required this.name,
    required this.phone,
    required this.selectedPlan,
    required this.selectedPlanId,
    required this.selectedMeals,
    required this.selectedDeliveryDays,
    required this.allergies,
    required this.additionalRequest,
  });
}
