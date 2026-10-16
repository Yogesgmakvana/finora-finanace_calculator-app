import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeoCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Offset shadowOffset;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;

  const NeoCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.cardWhite,
    this.borderColor = AppColors.borderBlack,
    this.borderWidth = 1.8,
    this.borderRadius = 20.0,
    this.shadowOffset = const Offset(3, 3),
    this.padding = const EdgeInsets.all(16.0),
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: shadowOffset != Offset.zero
            ? [
                BoxShadow(
                  color: borderColor,
                  offset: shadowOffset,
                  blurRadius: 0,
                )
              ]
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
