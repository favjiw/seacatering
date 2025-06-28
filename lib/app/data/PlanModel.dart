class PlanModel {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final String imageCircleUrl;
  final String shortDesc;
  final String desc;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final int fiber;

  PlanModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.imageCircleUrl,
    required this.shortDesc,
    required this.desc,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      imageUrl: map['image_url'] ?? '',
      imageCircleUrl: map['image_circle_url'] ?? '',
      shortDesc: map['short_desc'] ?? '',
      desc: map['desc'] ?? '',
      calories: map['calories'] ?? 0,
      protein: map['protein'] ?? 0,
      carbs: map['carbs'] ?? 0,
      fat: map['fat'] ?? 0,
      fiber: map['fiber'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'image_circle_url': imageCircleUrl,
      'short_desc': shortDesc,
      'desc': desc,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
    };
  }

  // factory PlanModel.empty() => PlanModel(
  //   id: '',
  //   name: '',
  //   price: 0,
  //   imageUrl: '',
  //   imageCircleUrl: '',
  //   shortDesc: '',
  //   desc: '',
  //   calories: 0,
  //   protein: 0,
  //   carbs: 0,
  //   fat: 0,
  //   fiber: 0,
  // );
}
