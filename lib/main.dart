import 'package:flutter/material.dart';
import 'currency_converter_material_page.dart';

void main() {
  runApp(MyApp());
}

// State

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: const CurrencyConverterMaterialPage(),
     debugShowCheckedModeBanner: false,
    );
  }
}
