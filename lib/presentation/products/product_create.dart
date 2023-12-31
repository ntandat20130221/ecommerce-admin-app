import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_admin_app/domain/brand.dart';
import 'package:ecommerce_admin_app/domain/image_path.dart';
import 'package:ecommerce_admin_app/domain/product.dart';
import 'package:ecommerce_admin_app/domain/size.dart';
import 'package:ecommerce_admin_app/domain/type.dart';
import 'package:ecommerce_admin_app/presentation/products/image_viewer.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DropdownModel {
  DropdownModel({required this.id, required this.name, this.isSelected = false});
  int id;
  String name;
  bool isSelected;
}

class InventoryModel {
  InventoryModel({required this.sizes, required this.quantityController});
  List<DropdownModel> sizes;
  TextEditingController quantityController;
}

class ProductCreate extends StatefulWidget {
  const ProductCreate({super.key, this.product});

  final Product? product;

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  final ProductRepository productRepository = ProductRepositoryImpl();

  final nameController = TextEditingController();
  final listedPriceController = TextEditingController();
  final promPriceController = TextEditingController();

  final brands = [
    DropdownModel(id: 1, name: 'Nike'),
    DropdownModel(id: 2, name: 'Adidas'),
    DropdownModel(id: 3, name: 'Puma'),
  ];

  final types = [
    DropdownModel(id: 1, name: 'Áo đấu'),
    DropdownModel(id: 2, name: 'Áo huấn luyện'),
    DropdownModel(id: 3, name: 'Áo thủ môn'),
    DropdownModel(id: 4, name: 'Áo fan'),
  ];

  final genders = [
    DropdownModel(id: 1, name: 'Male'),
    DropdownModel(id: 2, name: 'Female'),
  ];

  final inventories = [
    InventoryModel(
      sizes: [
        DropdownModel(id: 1, name: 'S'),
        DropdownModel(id: 2, name: 'M'),
        DropdownModel(id: 3, name: 'L'),
        DropdownModel(id: 4, name: 'XL'),
        DropdownModel(id: 5, name: 'XXL'),
      ],
      quantityController: TextEditingController(),
    ),
  ];

  final imagePaths = <ImagePath>[];

  bool get isEdit => widget.product != null;
  bool isLoading = false;

  void onSave() async {
    final gender = genders.where((element) => element.isSelected).firstOrNull;
    final brandModel = brands.firstWhere((brand) => brand.isSelected, orElse: () => brands.first);
    final typeModel = types.firstWhere((type) => type.isSelected, orElse: () => types.first);
    final product = Product(
      id: widget.product?.id ?? 0,
      name: nameController.text,
      gender: gender == null ? false : gender.id == 1,
      star: 0,
      brand: Brand(id: brandModel.id, name: brandModel.name),
      type: Type(id: typeModel.id, name: typeModel.name),
      listedPrice: double.parse(listedPriceController.text),
      price: double.parse(promPriceController.text),
      sizes: inventories
          .map((e) => Size(name: e.sizes.firstWhere((element) => element.isSelected).name, quantity: int.parse(e.quantityController.text)))
          .toList(),
      imagePaths: imagePaths,
      timeCreated: DateTime.now(),
    );

    final isSuccessful = isEdit ? await productRepository.updateProduct(product) : await productRepository.createProduct(product);
    if (isSuccessful && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void populateData() async {
    setState(() => isLoading = true);
    final product = widget.product;
    if (isEdit && product != null) {
      nameController.text = product.name;
      listedPriceController.text = product.listedPrice.toString();
      promPriceController.text = product.price.toString();
      for (final element in brands) {
        element.isSelected = element.id == product.brand.id;
        if (element.isSelected) break;
      }
      for (final element in types) {
        element.isSelected = element.id == product.type.id;
        if (element.isSelected) break;
      }
      genders[product.gender ? 0 : 1].isSelected = true;
      for (int i = 1; i < product.sizes.length; i++) {
        inventories.add(
          InventoryModel(
            sizes: [
              DropdownModel(id: 1, name: 'S'),
              DropdownModel(id: 2, name: 'M'),
              DropdownModel(id: 3, name: 'L'),
              DropdownModel(id: 4, name: 'XL'),
              DropdownModel(id: 5, name: 'XXL'),
            ],
            quantityController: TextEditingController(),
          ),
        );
      }
      for (final (index, element) in inventories.indexed) {
        for (final size in element.sizes) {
          size.isSelected = product.sizes[index].name == size.name;
          if (size.isSelected) break;
        }
        element.quantityController.text = product.sizes[index].quantity.toString();
      }
      imagePaths.addAll([...product.imagePaths]);
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    populateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Product' : 'Create Product'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
        actions: [IconButton(onPressed: () => onSave(), icon: const Icon(Icons.check, color: Colors.white))],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding),
                  section(
                    'Discription',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: defaultPadding / 2 + 4),
                        textField(controller: nameController),
                        const SizedBox(height: defaultPadding),
                        const Text('Business Description', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: defaultPadding / 2 + 4),
                        textField(minLines: 5),
                      ],
                    ),
                  ),
                  section(
                    'Category',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Product Brand', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: defaultPadding / 2 + 4),
                        dropdownButton(brands),
                        const SizedBox(height: defaultPadding),
                        const Text('Product Type', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: defaultPadding / 2 + 4),
                        dropdownButton(types),
                        const SizedBox(height: defaultPadding),
                        const Text('Gender', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: defaultPadding / 2 + 4),
                        dropdownButton(genders),
                      ],
                    ),
                  ),
                  sectionInventory(),
                  section(
                    'Pricing',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Listed Price', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: defaultPadding / 2 + 4),
                        textField(controller: listedPriceController, leadingText: 'VND'),
                        const SizedBox(height: defaultPadding),
                        const Text('Promotional Price', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: defaultPadding / 2 + 4),
                        textField(controller: promPriceController, leadingText: 'VND'),
                      ],
                    ),
                  ),
                  sectionImages()
                ],
              ),
            ),
    );
  }

  Widget textField({
    TextEditingController? controller,
    int minLines = 1,
    String? leadingText,
  }) =>
      Row(
        children: [
          Expanded(
            flex: 8,
            child: TextField(
              controller: controller,
              keyboardType: minLines > 1 ? TextInputType.multiline : null,
              maxLines: minLines == 1 ? minLines : null,
              minLines: minLines,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: textBorderColor, width: 1.5),
                    borderRadius: leadingText == null
                        ? const BorderRadius.all(Radius.circular(8))
                        : const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade500, width: 2.0),
                    borderRadius: leadingText == null
                        ? const BorderRadius.all(Radius.circular(8))
                        : const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
            ),
          ),
          leadingText != null
              ? Expanded(
                  flex: 2,
                  child: Container(
                    height: 52,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D2F3A),
                      border: Border(
                        top: BorderSide(color: textBorderColor, width: 1.5),
                        right: BorderSide(color: textBorderColor, width: 1.5),
                        bottom: BorderSide(color: textBorderColor, width: 1.5),
                      ),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                    ),
                    child: Center(child: Text(leadingText)),
                  ),
                )
              : const SizedBox(width: 0),
        ],
      );

  Widget dropdownButton(List<DropdownModel> items) {
    items.where((element) => element.isSelected).firstOrNull;
    return DropdownButtonFormField2<int>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 14, right: 10, bottom: 14, left: 0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: textBorderColor, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade500, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem<int>(
                value: item.id,
                child: Text(item.name, style: const TextStyle(fontSize: 14)),
              ))
          .toList(),
      value: items.where((element) => element.isSelected).firstOrNull?.id,
      onChanged: (value) {
        setState(() {
          for (final item in items) {
            item.isSelected = item.id == value;
          }
        });
      },
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xFF212229)),
      ),
    );
  }

  Widget sectionInventory() => section(
        'Inventory',
        child: Column(
          children: [
            const Row(children: [
              Expanded(flex: 3, child: Text('Size', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
              SizedBox(width: defaultPadding + 8),
              Expanded(flex: 4, child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
              SizedBox(width: 50)
            ]),
            const SizedBox(height: defaultPadding / 2 + 4),
            for (final (index, inventory) in inventories.indexed)
              Column(
                children: [
                  SizedBox(height: index == 0 ? 0 : defaultPadding / 2 + 4),
                  Row(
                    children: [
                      Expanded(flex: 3, child: dropdownButton(inventory.sizes)),
                      const SizedBox(width: defaultPadding + 8, child: Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Divider())),
                      Expanded(flex: 4, child: textField(controller: inventory.quantityController)),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: colorSecondary,
                        child: IconButton(
                            onPressed: () {
                              if (index == 0) {
                                // Add more row.
                                setState(() {
                                  inventories.add(
                                    InventoryModel(
                                      sizes: [
                                        DropdownModel(id: 1, name: 'S'),
                                        DropdownModel(id: 2, name: 'M'),
                                        DropdownModel(id: 3, name: 'L'),
                                        DropdownModel(id: 4, name: 'XL'),
                                        DropdownModel(id: 5, name: 'XXL'),
                                      ],
                                      quantityController: TextEditingController(),
                                    ),
                                  );
                                });
                              } else {
                                // Remove this row.
                                setState(() {
                                  inventories.removeAt(index);
                                });
                              }
                            },
                            icon: Icon(index == 0 ? Icons.add : Icons.remove)),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      );

  Widget sectionImages() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Row(children: [Text('Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
        ),
        SizedBox(height: imagePaths.isEmpty ? 0 : defaultPadding),
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
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageViewer(imagePath))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: imagePath.from == From.local ? Image.file(File(imagePath.path)) : Image.network(imagePath.path),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: defaultPadding / 4, right: defaultPadding / 4),
                    child: IconButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(129, 37, 37, 37))),
                      onPressed: () => setState(() => imagePaths.remove(imagePath)),
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
                setState(() {
                  for (final path in paths) {
                    imagePaths.add(ImagePath(path: path, from: From.local));
                  }
                });
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: colorSecondary),
            icon: const Icon(Icons.upload),
            label: const Text('Upload images'),
          ),
        )
      ],
    );
  }

  Widget section(String title, {required Widget child}) => Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: defaultPadding),
            Container(
              decoration: BoxDecoration(color: containerColor, borderRadius: BorderRadius.circular(defaultPadding / 2)),
              child: Padding(padding: const EdgeInsets.all(defaultPadding), child: child),
            )
          ],
        ),
      );
}
