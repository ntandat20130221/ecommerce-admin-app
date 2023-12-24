import 'dart:io';

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
  final imageFiles = <File>[];
  int sizeCount = 1;
  int gender = 0;
  String brand = 'ad';
  String type = 'one';

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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check, color: Colors.white))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            field('Name', 'Product name'),
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
                    value: brand,
                    onChanged: (value) => setState(() => brand = value ?? 'ad'),
                    items: const [
                      DropdownMenuItem(value: 'ad', child: Text('Adidas')),
                      DropdownMenuItem(value: 'pu', child: Text('Puma')),
                      DropdownMenuItem(value: 'ni', child: Text('Nike')),
                    ],
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
                    value: type,
                    onChanged: (value) => setState(() => type = value ?? 'one'),
                    items: const [
                      DropdownMenuItem(value: 'one', child: Text('Type One')),
                      DropdownMenuItem(value: 'two', child: Text('Type Two')),
                      DropdownMenuItem(value: 'three', child: Text('Type Three')),
                    ],
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
                      Row(children: [Expanded(child: field('Size', 'Product size')), Expanded(child: field('Quantity', 'Product quantity'))]),
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
            field('Listed price', 'Price', 'VNĐ'),
            const SizedBox(height: defaultPadding),
            field('Promotion price', 'Price', 'VNĐ'),
            const SizedBox(height: defaultPadding),
            images()
          ],
        ),
      ),
    );
  }

  Widget field(String label, [String? hint, String? suffixText]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(decoration: InputDecoration(filled: false, hintText: hint, suffixText: suffixText)),
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
