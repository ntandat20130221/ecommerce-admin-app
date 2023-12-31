import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/domain/brand.dart';
import 'package:ecommerce_admin_app/domain/image_path.dart';
import 'package:ecommerce_admin_app/domain/size.dart';
import 'package:ecommerce_admin_app/domain/type.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.gender,
    required this.star,
    required this.brand,
    required this.type,
    required this.listedPrice,
    required this.price,
    required this.sizes,
    required this.imagePaths,
    required this.timeCreated,
  });

  int id;
  String name;
  bool gender;
  int star;
  Brand brand;
  Type type;
  double listedPrice, price;
  List<Size> sizes;
  List<ImagePath> imagePaths;
  DateTime timeCreated;

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        gender = json['gender'],
        star = json['star'],
        brand = Brand.fromJson(json['brand']),
        type = Type.fromJson(json['type']),
        listedPrice = json['listedPrice'],
        price = json['price'],
        sizes = List<Size>.from(json['sizes'].map((sizeJson) => Size.fromJson(sizeJson))),
        imagePaths = (json['images'] as List).map((e) => ImagePath(path: '$baseUrl/api/product/$e', from: From.network)).toList(),
        timeCreated = DateTime.parse(json['timeCreated']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'star': star,
        'brand': {
          'id': brand.id,
          'nameBrand': brand.name,
        },
        'type': {
          'id': type.id,
          'nameType': type.name,
        },
        'listedPrice': listedPrice,
        'price': price,
        'sizes': [
          ...sizes.map(
            (size) => {
              'name': size.name,
              'quantity': size.quantity,
            },
          )
        ],
        'images': [],
        'timeCreated': DateTime.now().toIso8601String()
      };
}
