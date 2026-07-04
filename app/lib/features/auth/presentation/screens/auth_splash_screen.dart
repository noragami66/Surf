import 'package:flutter/material.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/ambient_background.dart';

/// Shown while the stored session is being resolved (AuthStatus.unknown).
class AuthSplashScreen extends StatelessWidget {
  const AuthSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.voidBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AmbientBackground(),
          Center(
            child: Text(
              'Глина',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }
}
