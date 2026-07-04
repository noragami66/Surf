import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/widgets/glass_primary_button.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/auth/presentation/widgets/auth_error_text.dart';
import 'package:glina/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:glina/features/auth/presentation/widgets/glass_text_field.dart';
import 'package:glina/l10n/app_localizations.dart';

/// UC-5.3 — display name entry for a new client.
class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid => _controller.text.trim().isNotEmpty;

  void _submit() {
    if (!_isValid) {
      return;
    }
    context.read<AuthBloc>().add(AuthNameSubmitted(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AuthScaffold(
          title: l10n.authNameTitle,
          subtitle: l10n.authNameSubtitle,
          children: [
            GlassTextField(
              controller: _controller,
              label: l10n.authNameLabel,
              hint: l10n.authNameHint,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              autofocus: true,
              onSubmitted: (_) => _submit(),
            ),
            AuthErrorText(code: state.errorCode),
            const SizedBox(height: 24),
            GlassPrimaryButton(
              label: l10n.authFinish,
              isLoading: state.isSubmitting,
              onPressed: _submit,
            ),
          ],
        );
      },
    );
  }
}
