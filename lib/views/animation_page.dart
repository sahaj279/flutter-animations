import 'package:flutter/material.dart';
import 'package:page_flip_animation/views/animating_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: 
      const Color(0xfffcdfcc),
      appBar:  AppBar(
        backgroundColor: 
      const Color(0xfffcdfcc),
        title: const Text('Flip Page Animation'),
        centerTitle: true,
      ),
      body:const AnimationWidget()
    );
  }
}
