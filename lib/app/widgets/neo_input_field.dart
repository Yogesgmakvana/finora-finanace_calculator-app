import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeoInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType keyboardType;
  final bool isTenureField;
  final bool isYearSelected;
  final ValueChanged<bool>? onTenureToggle;
  final ValueChanged<String>? onChanged;

  const NeoInputField({
    super.key,
    required this.label,
    required this.controller,
    this.prefixIcon,
    this.hintText,
    this.keyboardType = TextInputType.number,
    this.isTenureField = false,
    this.isYearSelected = true,
    this.onTenureToggle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300, width: 1.2),
          ),
          child: Row(
            children: [
              if (prefixIcon != null) ...[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(child: prefixIcon),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              if (isTenureField) ...[
                const SizedBox(width: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onTenureToggle?.call(true),
                      child: Text(
                        'Y',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isYearSelected
                              ? AppColors.textBlack
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => onTenureToggle?.call(false),
                      child: Text(
                        'M',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: !isYearSelected
                              ? AppColors.btnEmeraldGreen
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
