class OrderStatusStatistic {
  OrderStatusStatistic({this.id, this.name, this.quantity, this.percentage});

  int? id;
  String? name;
  int? quantity;
  num? percentage;

  OrderStatusStatistic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        quantity = json['quantity'],
        percentage = json['percentage'];
}
