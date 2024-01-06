import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(this.image, {super.key});

  final dynamic image;

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
        child: Center(child: image is String ? Image.network(image) : Image.file(image)),
      ),
    );
  }
}
