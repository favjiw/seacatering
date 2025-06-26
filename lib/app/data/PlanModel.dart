class PlanModel {
  final String name;
  final int price;
  final String id;
  final String imageUrl;
  final String desc;

  PlanModel({
    required this.name,
    required this.price,
    required this.id,
    required this.imageUrl,
    required this.desc,
  });

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      id: map['id'] ?? '',
      imageUrl: map['image_url'] ?? '',
      desc: map['desc'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'id': id,
      'image_url': imageUrl,
      'desc': desc,
    };
  }
}
