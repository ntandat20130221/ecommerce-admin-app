class Type {
  Type({required this.id, required this.name, this.isSelected = false});

  int id;
  String name;
  bool isSelected;

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      name: json['nameType'],
    );
  }
}
