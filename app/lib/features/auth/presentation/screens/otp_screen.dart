import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/glass_primary_button.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/auth/presentation/widgets/auth_error_text.dart';
import 'package:glina/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:glina/features/auth/presentation/widgets/glass_text_field.dart';
import 'package:glina/l10n/app_localizations.dart';

/// UC-5.2 — OTP entry.
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controller = TextEditingController();

  static const _codeLength = 4;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid => _controller.text.trim().length == _codeLength;

  void _submit() {
    if (!_isValid) {
      return;
    }
    context.read<AuthBloc>().add(AuthCodeVerified(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<AuthBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AuthScaffold(
          title: l10n.authOtpTitle,
          subtitle: l10n.authOtpSubtitle(state.phone),
          onBack: () => bloc.add(const AuthReset()),
          children: [
            GlassTextField(
              controller: _controller,
              label: l10n.authOtpHintMock,
              hint: '0000',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autofocus: true,
              maxLength: _codeLength,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onSubmitted: (_) => _submit(),
            ),
            AuthErrorText(code: state.errorCode),
            const SizedBox(height: 24),
            GlassPrimaryButton(
              label: l10n.authVerify,
              isLoading: state.isSubmitting,
              onPressed: _submit,
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: state.isSubmitting
                    ? null
                    : () => bloc.add(AuthCodeRequested(state.phone)),
                child: Text(
                  l10n.authResendCode,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Palette.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
