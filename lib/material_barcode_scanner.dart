import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

class MaterialBarcodeScanner extends StatefulWidget {
  const MaterialBarcodeScanner({Key? key}) : super(key: key);

  @override
  _MaterialBarcodeScannerState createState() => _MaterialBarcodeScannerState();
}

class _MaterialBarcodeScannerState extends State<MaterialBarcodeScanner> {
  final ImagePicker _picker = ImagePicker();
  String _barcodeResult = '';

  Future<void> _scanBarcode() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final inputImage = InputImage.fromFilePath(image.path);
    final barcodeScanner = BarcodeScanner();

    final barcodes = await barcodeScanner.processImage(inputImage);
    if (barcodes.isEmpty) {
      setState(() => _barcodeResult = 'No barcode found.');
    } else {
      setState(() {
        _barcodeResult = barcodes.map((b) => b.rawValue ?? '').join('\n');
      });
    }

    barcodeScanner.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _scanBarcode,
              child: const Text('Pick Image and Scan Barcode'),
            ),
            const SizedBox(height: 20),
            Text('Result:\n$_barcodeResult'),
          ],
        ),
      ),
    );
  }
}
