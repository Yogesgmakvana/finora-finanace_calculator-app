import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeoTopPill extends StatelessWidget {
  final String title;

  const NeoTopPill({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.borderBlack, width: 2.0),
        boxShadow: const [
          BoxShadow(
            color: AppColors.borderBlack,
            offset: Offset(3, 3),
            blurRadius: 0,
          )
        ],
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
