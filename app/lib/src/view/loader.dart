import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoaderView extends StatefulWidget {
  const LoaderView({super.key});

  @override
  State<LoaderView> createState() => _LoaderViewState();
}

class _LoaderViewState extends State<LoaderView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

  @override
  dispose() {
    _controller.dispose();
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
            return Transform(
              transform: Matrix4.rotationY(_controller.value * 2 * math.pi),
              alignment: Alignment.center,
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
