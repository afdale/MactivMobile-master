class User {
  final String name;
  final String email;
  final int userId;

  User({
    this.name,
    this.email,
    this.userId
  });

  User.fromJson(Map<String, dynamic> json):
    name = json['name'],
    email = json['email'],
    userId = json['userId'];

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'email': email,
      'userId': userId,
    };
}