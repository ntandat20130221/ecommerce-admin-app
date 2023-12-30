class Brand {
  Brand({required this.id, required this.name});

  int id;
  String name;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['nameBrand'],
    );
  }
}
