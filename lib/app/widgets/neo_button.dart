import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeoButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double? width;
  final IconData? icon;

  const NeoButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = AppColors.btnClearWhite,
    this.textColor = AppColors.textBlack,
    this.height = 48.0,
    this.width,
    this.icon,
  });

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.borderBlack, width: 2.0),
          boxShadow: _isPressed
              ? []
              : const [
                  BoxShadow(
                    color: AppColors.borderBlack,
                    offset: Offset(3, 3),
                    blurRadius: 0,
                  )
                ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: widget.textColor),
                const SizedBox(width: 6),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
