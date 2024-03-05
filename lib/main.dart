import 'package:flutter/material.dart';
import 'package:test_venturo/view/ui/cart_screen.dart';
import 'package:provider/provider.dart';
import 'controllers/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenusController(),
      child: MaterialApp(
        title: 'Venturo App',
        home: CartScreen(),
      ),
    );
  }
}
