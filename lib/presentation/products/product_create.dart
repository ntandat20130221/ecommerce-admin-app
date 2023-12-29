import 'dart:io';

import 'package:ecommerce_admin_app/data/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_admin_app/domain/brand.dart';
import 'package:ecommerce_admin_app/domain/product.dart';
import 'package:ecommerce_admin_app/domain/type.dart';
import 'package:ecommerce_admin_app/domain/size.dart';
import 'package:ecommerce_admin_app/presentation/products/image_viewer.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductCreate extends StatefulWidget {
  const ProductCreate({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  final ProductRepository productRepository = ProductRepositoryImpl();

  final nameController = TextEditingController();

  final List<Map<String, TextEditingController>> sizeQuantityControllers = [
    {
      'size': TextEditingController(),
      'quantity': TextEditingController(),
    }
  ];

  final listedPriceController = TextEditingController();
  final promPriceController = TextEditingController();

  final brands = [
    Brand(id: 1, name: 'Nike'),
    Brand(id: 2, name: 'Adidas'),
    Brand(id: 3, name: 'Puma'),
  ];

  final types = [
    Type(id: 1, name: 'Áo đấu'),
    Type(id: 2, name: 'Áo huấn luyện'),
    Type(id: 3, name: 'Áo thủ môn'),
    Type(id: 4, name: 'Áo fan'),
  ];

  final imagePaths = <String>[];
  int gender = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Product' : 'Create Product'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: colorBackground,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
        actions: [
          IconButton(
              onPressed: () async {
                final product = Product(
                  id: 0,
                  name: nameController.text,
                  gender: gender == 1,
                  star: 0,
                  brand: brands.firstWhere((brand) => brand.isSelected, orElse: () => brands.first),
                  type: types.firstWhere((type) => type.isSelected, orElse: () => types.first),
                  listedPrice: double.parse(listedPriceController.text),
                  price: double.parse(promPriceController.text),
                  sizes: sizeQuantityControllers
                      .map((sizeQuantity) => Size(name: sizeQuantity['size']!.text, quantity: int.parse(sizeQuantity['quantity']!.text)))
                      .toList(),
                  images: imagePaths,
                  timeCreated: DateTime.now(),
                );

                final isSuccessful = await productRepository.createProduct(product);

                if (isSuccessful && context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.check, color: Colors.white))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            field('Name', hint: 'Product name', controller: nameController),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Brand'),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(8.0),
                    isExpanded: true,
                    value: brands.firstWhere((brand) => brand.isSelected, orElse: () => brands.first).id.toString(),
                    onChanged: (value) => setState(() {
                      for (final brand in brands) {
                        brand.isSelected = brand.id.toString() == value;
                      }
                    }),
                    items: [...brands.map((brand) => DropdownMenuItem(value: brand.id.toString(), child: Text(brand.name)))],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Type'),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(8.0),
                    isExpanded: true,
                    value: types.firstWhere((type) => type.isSelected, orElse: () => types.first).id.toString(),
                    onChanged: (value) => setState(() {
                      for (final type in types) {
                        type.isSelected = type.id.toString() == value;
                      }
                    }),
                    items: [...types.map((type) => DropdownMenuItem(value: type.id.toString(), child: Text(type.name)))],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  Expanded(child: checkbox('Men', gender == 0)),
                  Expanded(child: checkbox('Women', gender == 1)),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            Column(
              children: [
                for (final sizeQuantity in sizeQuantityControllers)
                  Column(
                    children: [
                      Row(children: [
                        Expanded(child: field('Size', hint: 'Product size', controller: sizeQuantity['size']!)),
                        Expanded(child: field('Quantity', hint: 'Product quantity', controller: sizeQuantity['quantity']!))
                      ]),
                      const SizedBox(height: defaultPadding),
                    ],
                  ),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: colorSecondary,
                      child: IconButton(
                          onPressed: () => setState(() => sizeQuantityControllers.add({
                                'size': TextEditingController(),
                                'quantity': TextEditingController(),
                              })),
                          icon: const Icon(Icons.add)),
                    ),
                    const SizedBox(width: defaultPadding),
                    CircleAvatar(
                      backgroundColor: colorSecondary,
                      child: IconButton(onPressed: () => setState(() => sizeQuantityControllers.removeLast()), icon: const Icon(Icons.remove)),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: defaultPadding),
            field('Listed price', hint: 'Price', suffixText: 'VNĐ', controller: listedPriceController),
            const SizedBox(height: defaultPadding),
            field('Promotion price', hint: 'Price', suffixText: 'VNĐ', controller: promPriceController),
            const SizedBox(height: defaultPadding),
            images()
          ],
        ),
      ),
    );
  }

  Widget field(String label, {String? hint, String? suffixText, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            decoration: InputDecoration(filled: false, hintText: hint, suffixText: suffixText),
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget checkbox(String label, [bool? value = false]) {
    void check([bool? value]) => setState(() => gender = label == 'Men' ? 0 : 1);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: check,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: check,
          ),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }

  Widget images() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Row(children: [Text('Product images')]),
        ),
        const SizedBox(height: defaultPadding),
        SizedBox(
          height: imagePaths.isEmpty ? 0 : 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final imagePath = imagePaths[index];
              return Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageViewer(File(imagePath)))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.file(File(imagePath)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: defaultPadding / 4, right: defaultPadding / 4),
                    child: IconButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(129, 37, 37, 37))),
                      onPressed: () {
                        setState(() {
                          imagePaths.remove(imagePath);
                        });
                      },
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: defaultPadding),
            itemCount: imagePaths.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: ElevatedButton.icon(
              onPressed: () {
                final imagePicker = ImagePicker();
                imagePicker.pickMultiImage().then((xFiles) {
                  final paths = xFiles.map((e) => e.path);
                  setState(() => imagePaths.addAll(paths));
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: colorSecondary),
              icon: const Icon(Icons.upload),
              label: const Text('Upload images')),
        )
      ],
    );
  }
}
