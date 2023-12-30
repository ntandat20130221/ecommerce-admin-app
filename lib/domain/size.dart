class Size {
  Size({required this.name, required this.quantity});

  String name;
  int quantity;

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}
