class Chef {
  final String name;
  final String image;
  final String distance;
  final double rating;
  final int reviews;
  bool isFollowed;

  Chef({
    required this.name,
    required this.image,
    required this.distance,
    required this.rating,
    required this.reviews,
    this.isFollowed = false,
  });

  void toggleFollow() {
    isFollowed = !isFollowed;
  }
}
