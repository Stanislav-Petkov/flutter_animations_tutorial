import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // when the animation reaches the top, it goes to the bottom
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // if it is at its normal position, move it ahead
        controller.forward();

      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(200, 200),
                    painter: BouncingBallPainter(animation.value),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class BouncingBallPainter extends CustomPainter {
  final double animationValue;

  BouncingBallPainter(this.animationValue) {
    // animationValue comes from the tween values from 0 to 1
    // print('BouncingBallPainter $animationValue');
  }

  @override
  void paint(Canvas canvas, Size size) {
    // size show how much size is available;
    // size.width / 2 goes to the center
    // at size.height the ball is at the bottom
    var paint = Paint();
    paint.color = Colors.blue;
    // print('size.height ${size.height}');
    // print('y: ${size.height - (size.height * animationValue)}');
    // The animation is that the ball goes from bottom to top
    canvas.drawCircle(
        Offset(size.width / 2, size.height - (size.height * animationValue)),
        20,
        Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // return true if we get new values
    return true;
  }
}
