
import 'package:flutter/material.dart';

class LoginScreenAnimation extends StatefulWidget {
  const LoginScreenAnimation({super.key});

  @override
  State<LoginScreenAnimation> createState() => _LoginScreenAnimationState();
}

class _LoginScreenAnimationState extends State<LoginScreenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> logoFadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    // The flutter logo at the beginning is not visible so 0, then
    // it is completely visible so 1
    logoFadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    // The start and end of the user and pass fields animation
    // The start is from x = -1 , which is most left, and y -1, which is
    // most up. Offset.zero is the center
    // In order to have a curve, we need to use CurvedAnimation
    slideAnimation = Tween(begin: const Offset(-1, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );
    logoFadeAnimation.addListener(() {
      if(logoFadeAnimation.isCompleted){
        // controller.reverse();// reverse the animations
        print('logoFadeAnimation.isCompleted');
      }else if(logoFadeAnimation.isDismissed){
        print('logoFadeAnimation.isDismissed');
      }
      // do something while the animation
      // print('logo fade animation');
    });

    // Explicitly tell the animation to start
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // We do not use AnimatedOpacity, because it takes double
            FadeTransition(
              opacity: logoFadeAnimation,
              child: const FlutterLogo(
                size: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
