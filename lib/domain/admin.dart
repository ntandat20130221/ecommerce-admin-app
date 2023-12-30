class Admin {
  Admin({required this.email, required this.password});

  String email;
  String password;

  factory Admin.fromJson(Map<String, dynamic> map) {
    return Admin(email: map['email'], password: map['password']);
  }
}
