class Movie {
  Movie({
    required this.bannerUrl,
    required this.posterUrl,
    required this.title,
    required this.rating,
    required this.starRating,
    required this.categories,
    required this.storyline,
    required this.photoUrls,
    required this.movieUrls,
    required this.actors,
    required  this.ParentId,
  });

  final String bannerUrl;
  final String posterUrl;
  final String title;
  final int ParentId;
  final double rating;
  final int starRating;
  final List<String> categories;
  final String storyline;
  final List<String> photoUrls;
  final List<String> movieUrls;
  final List<Actor> actors;
}

class Actor {
  Actor({
    required this.name,
    required this.avatarUrl,
  });

  final String name;
  final String avatarUrl;
}