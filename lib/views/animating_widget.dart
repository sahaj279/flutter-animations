import 'dart:math';

import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({super.key});

  @override
  State<AnimationWidget> createState() => _TestScreenState();
}

class _TestScreenState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  Animation<double>? _goingBackAnimation;
  Animation<double>? _comingForwardAnimation;
  bool _isBottomPageVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _goingBackAnimation =Tween<double>(begin: 30, end: 20).animate(_animationController!);
    _comingForwardAnimation =Tween<double>(begin: -20, end: -30).animate(_animationController!);
    _animation =Tween<double>(begin: -30, end: -150).animate(_animationController!);
    // print(_goingBackAnimation!.status);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void _flipPage() {
    if (_isBottomPageVisible) {
      _animationController!.forward().whenComplete(() {
        setState(() {
          _isBottomPageVisible = false;
        });
      });
    } else {
      _animationController!.reverse().whenComplete(() {
        setState(() {
          _isBottomPageVisible = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // double topPageAngle = 30; //goes from 30 to 20
    // double bottomPageAngle=-30;//start from -30 to -150
    //bottom most page goes from -20 to -30
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(20 / 180 * pi),
                  child: Container(
                    width: 270,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: Colors.blue.shade900),
                  ),
                ),
                AnimatedBuilder(
                  animation: _goingBackAnimation!,
                  builder: ((context, child) =>Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(_goingBackAnimation!.value / 180 * pi),
                    child: Container(
                      width: 270,
                      height: 200,
                      decoration:const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                        color: Colors.blue),
                    ),
                  )),
                ),
                
              ],
            ),
            Stack(
              children: [
                AnimatedBuilder(
                  animation: _comingForwardAnimation!,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(_comingForwardAnimation!.value / 180 * pi),
                      child: Container(
                        width: 270,
                        height: 200,
                        decoration: BoxDecoration(color: Colors.red.shade900, 
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animation!,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(_animation!.value / 180 * pi),
                      child: Container(
                        width: 270,
                        height: 200,
                        decoration:const BoxDecoration(color: Colors.red, 
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              foregroundColor: Color(0xff685c56),
              onPressed: _flipPage,
              child: const Icon(Icons.play_arrow),
            ),
          ]),
    );
  }
}
