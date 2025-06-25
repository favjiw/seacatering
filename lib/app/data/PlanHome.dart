class PlanHome {
  final String title;
  final String subtitle;
  final String price;
  final String imagePath;
  final String badgeImagePath;

  PlanHome({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
    required this.badgeImagePath,
  });
  factory PlanHome.empty() {
    return PlanHome(
      title: '',
      subtitle: '',
      price: '',
        imagePath: '',
      badgeImagePath: '',
    );
  }

}