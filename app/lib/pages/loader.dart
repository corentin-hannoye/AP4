import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.onPrimary,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * math.pi,
              child: child,
            );
          },
          child: Image.asset(
            'assets/images/logo.png',
            width: 50
          ),
        ),
      )
    );
  }
}

