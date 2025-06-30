import 'Testimony.dart';

class HomeTestimony {
  final String content;
  final String userName;
  final String planName;
  final int rating;

  HomeTestimony({
    required this.content,
    required this.userName,
    required this.planName,
    required this.rating,
  });

  factory HomeTestimony.fromFirestoreTestimony(Testimony testimony) {
    return HomeTestimony(
      content: testimony.message,
      userName: testimony.userName,
      planName: testimony.planName,
      rating: testimony.rating,
    );
  }
}