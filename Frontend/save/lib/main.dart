import 'package:flutter/material.dart';
import 'package:save/category_add_edit.dart';
import 'package:save/category_list.dart';
import 'package:save/pages/home_page.dart';
import 'package:save/pages/login_page.dart';
import 'package:save/pages/register_page.dart';
import 'package:save/pages/splashscreen.dart';
import 'package:save/product_add_edit.dart';
import 'package:save/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Save E-Storage',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
     routes: {
      '/': (context) => const SpalashScrren(),
      '/login': (context) => const LoginPage(),
      '/home':(context) => const HomePage(),
      '/register': (context) => const RegisterPage(),
      '/produks': (context) => const ProductList(),
      '/produkadd': (context) => const ProductAddEdit(),
      '/produkedit': (context) => const ProductAddEdit(), 
      '/cate': (context) => const CategoryList(),
      '/categoryadd': (context) => const CategoryAddEdit(),
      '/categoryedit': (context) => const CategoryAddEdit()
     },
    );
  }
}

 