import 'package:flutter/material.dart';

class GlowingDot extends StatefulWidget {
  final String dotColor;

  const GlowingDot({Key? key, required this.dotColor}) : super(key: key);

  @override
  _GlowingDotState createState() => _GlowingDotState();
}

class _GlowingDotState extends State<GlowingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 10 * _animation.value,
          height: 10 * _animation.value,
          decoration: BoxDecoration(
            color: Color(int.parse(widget.dotColor)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
