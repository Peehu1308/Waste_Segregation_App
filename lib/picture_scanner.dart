// TODO Implement this library.
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class PictureScanner extends StatefulWidget {
  const PictureScanner({Key? key}) : super(key: key);

  @override
  State<PictureScanner> createState() => _PictureScannerState();
}

class _PictureScannerState extends State<PictureScanner> {
  File? _image;
  List<ImageLabel> _labels = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final inputImage = InputImage.fromFilePath(picked.path);
      final labeler = ImageLabeler(options: ImageLabelerOptions());
      final labels = await labeler.processImage(inputImage);

      setState(() {
        _image = File(picked.path);
        _labels = labels;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Picture Scanner")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(onPressed: _pickImage, child: const Text("Pick Image")),
            if (_image != null) Image.file(_image!),
            const SizedBox(height: 10),
            ..._labels.map((label) => Text(
                "${label.label} (${(label.confidence * 100).toStringAsFixed(2)}%)"))
          ],
        ),
      ),
    );
  }
}
