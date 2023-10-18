import 'dart:async';

import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 10).animate(controller);
    controller.addListener(() {
      if (controller.isCompleted) {
        Navigator.of(context).push(
            MyCustomRouteTransition(route: const Destination())
        );
        Timer(const Duration(milliseconds: 500), () {
          controller.reset();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            controller.forward();
          },
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go Back'),
      ),
      body: const Center(
        child: Text('Hello'),
      ),
    );
  }
}

class MyCustomRouteTransition extends PageRouteBuilder {
  final Widget route;

  MyCustomRouteTransition({required this.route})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => route,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //opacity depends on how much of the transition has happened,
            // animation tells us the progress of the previous to the current page
            // child is Destination
            final tween = Tween(begin: const Offset(0, -1), end: Offset.zero)
                .animate(CurvedAnimation(
                    parent: animation, curve: Curves.easeInOut));
            return SlideTransition(
              position: tween,
              child: child,
            );
            // return FadeTransition(opacity: animation,child: child,);
          },
          transitionDuration: const Duration(seconds: 2),
        );
}
