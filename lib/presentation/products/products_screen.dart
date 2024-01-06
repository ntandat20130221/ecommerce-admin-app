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

  late ScrollController scrollController;

  late List<Product> products;
  bool isLoading = true;
  bool isLoadingMore = false;
  int page = 0, size = 10;

  void firstLoadProducts() async {
    setState(() => isLoading = true);
    products = await productRepository.getProducts(page = 0, size);
    setState(() => isLoading = false);
  }

  void loadMore() async {
    if (isLoading == false && isLoadingMore == false && scrollController.position.extentAfter < 300) {
      setState(() => isLoadingMore = true);
      products.addAll(await productRepository.getProducts(++page, size));
      setState(() => isLoadingMore = false);
    }
  }

  void navigateToProductCreateScreen([Product? product]) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductCreate(product: product)));
    // firstLoadProducts();
  }

  @override
  void initState() {
    super.initState();
    firstLoadProducts();
    scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    scrollController.removeListener(loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: (() async => firstLoadProducts()),
            notificationPredicate: (ScrollNotification notification) => notification.depth == 0,
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
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
                                  onPressed: () => navigateToProductCreateScreen(),
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
                            onTap: () => navigateToProductCreateScreen(product),
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(32),
                                      child: product.imagePaths.isNotEmpty
                                          ? Image.network(product.imagePaths.first)
                                          : Image.asset('assets/images/sample_product.jpeg'),
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
                                            onPressed: () => navigateToProductCreateScreen(product),
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
                                                  firstLoadProducts();
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
                ),
                if (isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
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
