import 'package:flutter/material.dart';
import 'package:protofolio/core/constants/app_constants.dart';

class PortfolioShell extends StatelessWidget {
  const PortfolioShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF7FBFD), Color(0xFFEAF5FA), Color(0xFFFDF7EF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          top: -100,
          right: -40,
          child: _BlurShape(
            color: AppConstants.kSecondaryColor.withValues(alpha: 0.16),
          ),
        ),
        Positioned(
          bottom: -120,
          left: -60,
          child: _BlurShape(
            color: AppConstants.kAccentColor.withValues(alpha: 0.18),
          ),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppConstants.kPageMaxWidth,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class _BlurShape extends StatelessWidget {
  const _BlurShape({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0.01)],
          ),
        ),
      ),
    );
  }
}
