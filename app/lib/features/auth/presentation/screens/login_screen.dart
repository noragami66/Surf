import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/auth/presentation/widgets/auth_error_text.dart';
import 'package:glina/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:glina/features/auth/presentation/widgets/glass_primary_button.dart';
import 'package:glina/features/auth/presentation/widgets/glass_text_field.dart';
import 'package:glina/l10n/app_localizations.dart';

/// UC-5.1 — phone number entry.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();

  static const _minDigits = 10;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid {
    final digits = _controller.text.replaceAll(RegExp(r'\D'), '');
    return digits.length >= _minDigits;
  }

  void _submit() {
    if (!_isValid) {
      return;
    }
    context.read<AuthBloc>().add(AuthCodeRequested(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AuthScaffold(
          title: l10n.authPhoneTitle,
          subtitle: l10n.authPhoneSubtitle,
          children: [
            GlassTextField(
              controller: _controller,
              label: l10n.authPhoneLabel,
              hint: l10n.authPhoneHint,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9+ ]')),
              ],
              onSubmitted: (_) => _submit(),
            ),
            AuthErrorText(code: state.errorCode),
            const SizedBox(height: 24),
            GlassPrimaryButton(
              label: l10n.authContinue,
              isLoading: state.isSubmitting,
              onPressed: _submit,
            ),
          ],
        );
      },
    );
  }
}
