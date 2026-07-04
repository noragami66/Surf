import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glina/core/style/palette.dart';

/// Text field styled for the dark glass auth screens.
class GlassTextField extends StatelessWidget {
  const GlassTextField({
    required this.controller,
    required this.label,
    required this.hint,
    super.key,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus = false,
    this.maxLength,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final int? maxLength;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: Palette.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Palette.glassBorder),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            autofocus: autofocus,
            maxLength: maxLength,
            onSubmitted: onSubmitted,
            style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18),
            cursorColor: Palette.ember,
            decoration: InputDecoration(
              counterText: '',
              hintText: hint,
              hintStyle: theme.textTheme.bodyLarge?.copyWith(
                color: Palette.textMuted,
                fontSize: 18,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
