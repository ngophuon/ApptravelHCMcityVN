import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String imagePath;

  const DetailScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: "imageHero", // Tag phải trùng với tag trong Row
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}