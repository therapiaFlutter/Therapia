import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:therapia_flutter_application/core/pages/page_not_found.dart';
import 'package:therapia_flutter_application/core/widgets/BottomNavBar.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/HomePage.dart';
import 'package:therapia_flutter_application/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/LoginPage.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/SignupPage.dart';
import 'package:therapia_flutter_application/features/auth/presentation/pages/intro_screens.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'authentication',
        builder: (context, state) {
          return IntroScreens();
        },
        routes: [
          GoRoute(
            path: 'signup',
            name: 'signup',
            builder: (context, state) {
              return Signup();
            },
          ),
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (context, state) {
              return LoginPage();
            },
          ),

        ],
      ),
      GoRoute(
          path: '/GoogleBottomBar',
          name: 'GoogleBottomBar',
          builder: (context, state) {
            return GoogleBottomBar();
          }),
    ],

        errorBuilder: (context, state) => PageNotFound(),
    redirect: (context, state) {
      final bool unauthenticated = authBloc.state is UnAuthenticatedState;
      final bool authenticated = authBloc.state is AuthenticatedState;

      final bool isHomePage = (state.subloc == '/GoogleBottomBar');
      final bool isAuthOrLoginOrRegister = ((state.subloc == '/') ||
          (state.subloc == '/signup') ||
          (state.subloc == '/login'));

      if (unauthenticated) {
        return isHomePage ? '/' : null;
      }

      if (authenticated) {
        return isAuthOrLoginOrRegister ? '/GoogleBottomBar' : null;
      }
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
  
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

