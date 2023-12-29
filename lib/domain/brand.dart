class Brand {
  Brand({required this.id, required this.name, this.isSelected = false});

  int id;
  String name;
  bool isSelected;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['nameBrand'],
    );
  }
}
