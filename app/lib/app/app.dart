import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glina/app/router.dart';
import 'package:glina/core/auth/session_auth_bridge.dart';
import 'package:glina/core/style/app_theme.dart';
import 'package:glina/dependency_injection/locator/locator.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/my_bookings/presentation/manager/my_bookings_bloc/my_bookings_bloc.dart';
import 'package:glina/features/slots/presentation/manager/slots_bloc/slots_bloc.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GlinaApp extends StatefulWidget {
  const GlinaApp({super.key});

  @override
  State<GlinaApp> createState() => _GlinaAppState();
}

class _GlinaAppState extends State<GlinaApp> {
  late final AuthBloc _authBloc;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authBloc = locator<AuthBloc>()..add(const AuthStarted());
    locator<SessionAuthBridge>().onSessionExpired = () {
      if (!_authBloc.isClosed) {
        _authBloc.add(const AuthSessionExpired());
      }
    };
    _router = createRouter(_authBloc);
  }

  @override
  void dispose() {
    locator<SessionAuthBridge>().onSessionExpired = null;
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<SlotsBloc>(
          create: (_) => locator<SlotsBloc>()..add(const LoadSlotsEvent()),
        ),
        BlocProvider<MyBookingsBloc>(create: (_) => locator<MyBookingsBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == AuthStatus.unauthenticated,
        listener: (context, state) {
          context.read<MyBookingsBloc>().add(const ResetMyBookingsEvent());
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Glina',
          theme: buildAppTheme(),
          themeMode: ThemeMode.dark,
          locale: const Locale('ru'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: _router,
        ),
      ),
    );
  }
}
