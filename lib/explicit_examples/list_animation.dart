import 'package:flutter/material.dart';
// Staggered animation
class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  List<Animation<Offset>> animations = [];
  final int itemCount = 5;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    slideAnimation =
        Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(controller);
    // To add a delay between the slide transition animations of each
    // list tile, Interval is used. Ex if Duration is 6 seconds and we use
    // Interval(0.5,1) that means that the animation will start from the 3rd
    // second
    // index * (1 / itemCount) we delay the animation with equal amount of starting
    // animation
    animations = List.generate(
      itemCount,
      (index) => Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(index * (1 / itemCount),
              1), // 0.2 s interval between each list time
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: animations[index],
            child: ListTile(
              title: Text('Hello World, Rivaan. ${index.toString()}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
