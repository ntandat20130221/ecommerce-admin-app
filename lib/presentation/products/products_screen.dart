import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_admin_app/domain/product.dart';
import 'package:ecommerce_admin_app/presentation/products/product_create.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productRepository = ProductRepositoryImpl();
  late List<Product> products;
  var isLoading = true;

  void loadProducts() {
    productRepository.getProducts().then((value) {
      setState(() {
        products = value;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () async {
              loadProducts();
            },
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 0;
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: colorBackground,
                  surfaceTintColor: Colors.transparent,
                  leading: null,
                  automaticallyImplyLeading: false,
                  floating: true,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: defaultPadding),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: colorSecondary),
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductCreate())),
                            icon: const Icon(Icons.add),
                            label: const Text('Create'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SliverList.separated(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductCreate(product: product))),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: defaultPadding, top: defaultPadding, bottom: defaultPadding),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(32),
                                child: Image.network('$baseUrl/api/product/${product.images[0]}'),
                              ),
                            ),
                          ),
                          const SizedBox(width: defaultPadding),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name, style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 2.0),
                              Text('Total Quantity: ${product.sizes.map((e) => e.quantity).reduce((value, element) => value + element)}'),
                              const SizedBox(height: 2.0),
                              Text('Created at: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(product.timeCreated)}'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(height: 0, color: Color.fromARGB(255, 54, 58, 80)),
                ),
              ],
            ),
          );
  }
}
