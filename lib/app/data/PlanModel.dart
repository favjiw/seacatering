class PlanModel {
  final String name;
  final int price;
  final String uid;
  final String imageUrl;
  final String desc;

  PlanModel({
    required this.name,
    required this.price,
    required this.uid,
    required this.imageUrl,
    required this.desc,
  });

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      uid: map['uid'] ?? '',
      imageUrl: map['image_url'] ?? '',
      desc: map['desc'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'uid': uid,
      'image_url': imageUrl,
      'desc': desc,
    };
  }
}
