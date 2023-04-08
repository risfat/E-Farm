import 'package:flutter/material.dart';

enum AnimationType {
  slide,
  scale,
  fade,
}

void navigateToPage(BuildContext context, Widget destinationPage, AnimationType animationType) {

  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => destinationPage,
      transitionsBuilder: (_, animation, __, child) {
        switch (animationType) {
          case AnimationType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case AnimationType.scale:
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: child,
            );
          case AnimationType.fade:
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          default:
            return child;
        }
      },
    ),
  );
}
