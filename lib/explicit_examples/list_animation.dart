import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation> with SingleTickerProviderStateMixin {
  List<String> thoughts = [
    'Be my compiler, I want to execute my life.',
    'Public class Your World extends My World.',
    'May I append my surname to your name?',
    'We can merge, without conflicts!',
    'You are my zero index.',
  ];

  late AnimationController controller;
  late List<Animation<Offset>> slideAnimation = [];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    slideAnimation = List.generate(
        thoughts.length,
        (index) => Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: controller, curve: Interval(index * (1 / thoughts.length), 1))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
        itemCount: thoughts.length,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: slideAnimation[index],
            child: ListTile(
              title: Text(thoughts[index]),
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
