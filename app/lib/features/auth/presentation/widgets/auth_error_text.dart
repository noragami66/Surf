import 'package:flutter/material.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/l10n/app_localizations.dart';

/// Renders an auth error [code] as a localized message, or nothing when null.
class AuthErrorText extends StatelessWidget {
  const AuthErrorText({required this.code, super.key});

  final String? code;

  @override
  Widget build(BuildContext context) {
    if (code == null) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context)!;
    final message = switch (code) {
      'invalid_code' => l10n.authErrorInvalidCode,
      'rate_limited' => l10n.authErrorRateLimited,
      'network_error' => l10n.authErrorNetwork,
      _ => l10n.authErrorGeneric,
    };

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Palette.textSecondary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Palette.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
