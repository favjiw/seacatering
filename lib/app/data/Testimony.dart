class Testimony {
  final String content;
  final String userName;
  final String planName;
  final int rating;
  final String? avatarUrl;

  Testimony({
    required this.content,
    required this.userName,
    required this.planName,
    required this.rating,
    this.avatarUrl,
  });
}