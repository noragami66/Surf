import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glina/app/router.dart';
import 'package:glina/core/style/app_theme.dart';
import 'package:glina/dependency_injection/locator/locator.dart';
import 'package:glina/features/slots/presentation/manager/slots_bloc/slots_bloc.dart';
import 'package:glina/l10n/app_localizations.dart';

class GlinaApp extends StatelessWidget {
  const GlinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SlotsBloc>(
          create: (_) => locator<SlotsBloc>()..add(const LoadSlotsEvent()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Glina',
        theme: buildAppTheme(),
        locale: const Locale('ru'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: appRouter,
      ),
    );
  }
}
