import 'dart:io';

import 'package:ecommerce_admin_app/domain/image_path.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(this.imagePath, {super.key});

  final ImagePath imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(child: imagePath.from == From.local ? Image.file(File(imagePath.path)) : Image.network(imagePath.path)),
      ),
    );
  }
}
