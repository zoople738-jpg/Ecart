import 'package:flutter/material.dart';

import 'pages/login.dart';

void main() {
  runApp(const EcartApp());
}

class EcartApp extends StatelessWidget {
  const EcartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-cart',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}
