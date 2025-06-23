class PlanModel {
  final String title;
  final String subtitle;
  final String price;
  final String imagePath;
  final String badgeImagePath;

  PlanModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
    required this.badgeImagePath,
  });

  factory PlanModel.empty() => PlanModel(
    title: "",
    subtitle: "",
    price: "",
    imagePath: "",
    badgeImagePath: "",
  );
}