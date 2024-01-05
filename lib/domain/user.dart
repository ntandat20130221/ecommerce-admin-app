class User {
  User({this.userId, this.name, this.profileImage});

  int? userId;
  String? name, profileImage;

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int userId,
        'name': String name,
        'profileImage': String profileImage,
      } =>
        User(
          userId: userId,
          name: name,
          profileImage: profileImage,
        ),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}
