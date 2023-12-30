class Type {
  Type({required this.id, required this.name});

  int id;
  String name;

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      name: json['nameType'],
    );
  }
}
