import 'package:flutter/material.dart';

class LikesAnimation extends StatefulWidget {
  final Widget child; //make likeanimation a parnet widget
  final bool isAnimating;
  final Duration duration; //how long hold the animation
  final VoidCallback? onEnd;
  final bool smallLike; //small like button clicked or not
  const LikesAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 150),
      required this.isAnimating,
      this.onEnd,
      this.smallLike = false})
      : super(key: key);

  @override
  State<LikesAnimation> createState() => _LikesAnimationState();
}

class _LikesAnimationState extends State<LikesAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

//this widget will be called whenever our current widget is replaced by another widget
  @override
  void didUpdateWidget(covariant LikesAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(milliseconds: 200),
      );
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
