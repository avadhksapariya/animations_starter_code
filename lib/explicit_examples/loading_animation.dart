import 'package:flutter/material.dart';

class RadialProgressAnimation extends StatefulWidget {
  final double progress;
  final Color color;

  const RadialProgressAnimation({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  State<RadialProgressAnimation> createState() => _RadialProgressAnimationState();
}

class _RadialProgressAnimationState extends State<RadialProgressAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> loadAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    loadAnimation = Tween<double>(begin: 0, end: widget.progress).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: loadAnimation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: loadAnimation.value,
                      strokeWidth: 10,
                      backgroundColor: Colors.grey.shade100,
                      color: widget.color,
                    ),
                  ),
                  Text(
                    '${(loadAnimation.value * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}
