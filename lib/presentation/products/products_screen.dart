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
    setState(() => isLoading = true);
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
            onRefresh: (() async => loadProducts()),
            notificationPredicate: (ScrollNotification notification) => notification.depth == 0,
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
                            onPressed: () async {
                              await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductCreate()));
                              loadProducts();
                            },
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
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductCreate(product: product)));
                        loadProducts();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(32),
                                child: Image.network(product.imagePaths[0].path),
                              ),
                            ),
                            const SizedBox(width: defaultPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2.0),
                                Text('Total Quantity: ${product.sizes.map((e) => e.quantity).reduce((value, element) => value + element)}'),
                                const SizedBox(height: 2.0),
                                Text('Last update: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(product.timeCreated)}'),
                                const SizedBox(height: defaultPadding / 2),
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () async {
                                        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductCreate(product: product)));
                                        loadProducts();
                                      },
                                      style: TextButton.styleFrom(
                                          fixedSize: const Size(110, 20),
                                          foregroundColor: Colors.white,
                                          backgroundColor: colorSecondary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4.0),
                                            side: const BorderSide(color: Color.fromARGB(255, 90, 90, 90), width: 0.4),
                                          )),
                                      icon: const Icon(Icons.edit),
                                      label: const Text('Edit'),
                                    ),
                                    const SizedBox(width: defaultPadding / 2 + 4),
                                    TextButton.icon(
                                      onPressed: () {
                                        showDeleteDialog(
                                          context: context,
                                          onYes: () async {
                                            final isSuccessful = await productRepository.deleteProduct(product);
                                            if (isSuccessful && context.mounted) Navigator.of(context).pop();
                                            loadProducts();
                                          },
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        fixedSize: const Size(110, 20),
                                        foregroundColor: Colors.red.shade300,
                                        backgroundColor: colorSecondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                          side: const BorderSide(color: Color.fromARGB(255, 90, 90, 90), width: 0.4),
                                        ),
                                      ),
                                      icon: const Icon(Icons.delete),
                                      label: const Text('Delete'),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(height: 0, color: Color.fromARGB(255, 41, 43, 59)),
                ),
              ],
            ),
          );
  }
}

void showDeleteDialog({required BuildContext context, required void Function() onYes}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorDialog,
        surfaceTintColor: Colors.transparent,
        icon: const Icon(Icons.warning),
        iconColor: Colors.amber,
        title: const Text('Warning'),
        content: const Text('Are you sure you would like to delete this product? This action cannot be undone.'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
            onPressed: onYes,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
