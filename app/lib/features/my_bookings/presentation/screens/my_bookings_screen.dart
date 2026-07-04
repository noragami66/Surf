import 'package:flutter/material.dart';
import 'package:glina/l10n/app_localizations.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myBookingsTab)),
      body: const Center(child: Icon(Icons.event_note_outlined, size: 48)),
    );
  }
}
