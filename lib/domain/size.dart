class Size {
  Size({required this.name, required this.quantity, this.isSelected = false});

  String name;
  int quantity;
  bool isSelected;

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}