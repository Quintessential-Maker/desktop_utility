import 'package:flutter/material.dart';
import 'dart:math';

class HoverDanceImage extends StatefulWidget {
  @override
  _HoverDanceImageState createState() => _HoverDanceImageState();
}

class _HoverDanceImageState extends State<HoverDanceImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotate;
  late Animation<double> _scale;
  late Animation<double> _translateX;
  late Animation<double> _translateY;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _rotate = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scale = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _translateX = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _translateY = Tween<double>(begin: 0, end: -5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _startDance() {
    _controller.repeat(reverse: true);
  }

  void _stopDance() {
    _controller.stop();
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovering = true);
        _startDance();
      },
      onExit: (_) {
        setState(() => _hovering = false);
        _stopDance();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              _hovering ? _translateX.value : 0,
              _hovering ? _translateY.value : 0,
            ),
            child: Transform.rotate(
              angle: _hovering ? _rotate.value : 0,
              child: Transform.scale(
                scale: _hovering ? _scale.value : 1.0,
                child: child,
              ),
            ),
          );
        },
        child: Image.asset(
          'assets/images/pmposhan.png',
          fit: BoxFit.contain,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
