import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_admin_app/domain/brand.dart';
import 'package:ecommerce_admin_app/domain/type.dart';
import 'package:ecommerce_admin_app/presentation/products/image_viewer.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProductCreate extends StatefulWidget {
  const ProductCreate({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  final nameController = TextEditingController();
  final sizeController = TextEditingController();
  final quantityController = TextEditingController();
  final listedPriceController = TextEditingController();
  final promPriceController = TextEditingController();

  final brands = [
    Brand(1, 'Nike'),
    Brand(2, 'Adidas'),
    Brand(3, 'Puma'),
  ];

  final types = [
    Type(1, 'Áo đấu'),
    Type(2, 'Áo huấn luyện'),
    Type(3, 'Áo thủ môn'),
    Type(4, 'Áo fan'),
  ];

  final imageFiles = <File>[];
  int sizeCount = 1;
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
                final request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8080/api/products'));

                request.files.add(http.MultipartFile.fromString(
                  'product',
                  jsonEncode(
                    {
                      'nameProduct': nameController.text,
                      'starReview': 0,
                      'idStatusProduct': 1,
                      'listedPrice': listedPriceController.text,
                      'promotionalPrice': promPriceController.text,
                      'brand': {
                        'id': brands.firstWhere((brand) => brand.isSelected, orElse: () => brands.first).id,
                      },
                      'typeProduct': {
                        'id': types.firstWhere((type) => type.isSelected, orElse: () => types.first).id,
                      },
                      'idSex': gender,
                      'timeCreated': DateFormat('yyyy-MM-dd\'T\'HH:mm:ss').format(DateTime.now()),
                      'imageProducts': [],
                      'comments': [],
                    },
                  ),
                  contentType: MediaType('application', 'json'),
                ));

                final mutipartFiles = <http.MultipartFile>[];
                for (final file in imageFiles) {
                  final mutipartFile = await http.MultipartFile.fromPath('images', file.path);
                  mutipartFiles.add(mutipartFile);
                }
                request.files.addAll(mutipartFiles);

                final response = await request.send();

                if (response.statusCode == 200 && context.mounted) {
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
                for (int i = 0; i < sizeCount; i++)
                  Column(
                    children: [
                      Row(children: [
                        Expanded(child: field('Size', hint: 'Product size', controller: sizeController)),
                        Expanded(child: field('Quantity', hint: 'Product quantity', controller: quantityController))
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
                      child: IconButton(onPressed: () => setState(() => sizeCount++), icon: const Icon(Icons.add)),
                    ),
                    const SizedBox(width: defaultPadding),
                    CircleAvatar(
                      backgroundColor: colorSecondary,
                      child: IconButton(onPressed: () => setState(() => sizeCount--), icon: const Icon(Icons.remove)),
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
          height: imageFiles.isEmpty ? 0 : 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final imageFile = imageFiles[index];
              return Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageViewer(imageFile))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.file(imageFile),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: defaultPadding / 4, right: defaultPadding / 4),
                    child: IconButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(129, 37, 37, 37))),
                      onPressed: () {
                        setState(() {
                          imageFiles.remove(imageFile);
                        });
                      },
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: defaultPadding),
            itemCount: imageFiles.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: ElevatedButton.icon(
              onPressed: () {
                final imagePicker = ImagePicker();
                imagePicker.pickMultiImage().then((xFiles) {
                  final imageFiles = xFiles.map((e) => File(e.path));
                  setState(() => this.imageFiles.addAll(imageFiles));
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
