import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> bounceAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    bounceAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    bounceAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
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
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(200, 200),
                  painter: BouncingBallPainter(bounceAnimation.value),
                );
              },
              animation: bounceAnimation,
            ),
          ],
        ),
      ),
    );
  }
}

class BouncingBallPainter extends CustomPainter {
  BouncingBallPainter(this.animationValue);

  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(size.width / 2, size.height - (size.height * animationValue)), 20, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
