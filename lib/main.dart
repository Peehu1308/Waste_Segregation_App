import 'package:flutter/material.dart';
import 'camera_preview_scanner.dart';
import 'material_barcode_scanner.dart';
import 'picture_scanner.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => const ExampleList(),
        '/PictureScanner': (context) => const PictureScanner(),
        '/CameraPreviewScanner': (context) => const CameraPreviewScanner(),
        '/MaterialBarcodeScanner': (context) => const MaterialBarcodeScanner(),
      },
    ),
  );
}

class ExampleList extends StatelessWidget {
  const ExampleList({super.key});

  static final List<String> exampleWidgets = [
    'PictureScanner',
    'CameraPreviewScanner',
    'MaterialBarcodeScanner',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner Example')),
      body: ListView.builder(
        itemCount: exampleWidgets.length,
        itemBuilder: (context, index) {
          final widgetName = exampleWidgets[index];
          return ListTile(
            title: Text(widgetName),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/$widgetName'),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:waste_segregation/Screens/home.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }
