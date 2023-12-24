import 'package:ecommerce_admin_app/data/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/domain/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return [
      Product(id: 'P01', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P03', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P04', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P05', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P06', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P07', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P08', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P09', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P10', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P11', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P12', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P13', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
      Product(id: 'P14', name: 'Áo MU', description: 'Áo bóng đá MU', price: '50000VNĐ', images: ['assets/images/sample_product.jpeg'], sizes: ['M', 'L', 'XL', 'XXL']),
    ];
  }
}
