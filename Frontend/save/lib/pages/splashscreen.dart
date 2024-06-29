import 'dart:async';
import 'package:flutter/material.dart';
import 'package:save/category_list.dart';
import 'package:save/pages/home_page.dart';
import "package:save/pages/login_page.dart";
import 'package:save/product_list.dart'; 

class SpalashScrren extends StatefulWidget {
  const SpalashScrren({Key? key}) : super(key: key); 

  @override
  State<SpalashScrren> createState() => _SpalashScrrenState();
}

class _SpalashScrrenState extends State<SpalashScrren> {
  @override
  void initState() {
    super.initState();
    // Navigate to the main screen after 2 seconds
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage()),
        ),
      );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add your logo or image here
            Expanded(
              child: Image.asset(
                'assets/images/123.png', // Sesuaikan dengan lokasi dan nama file gambar Anda
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
