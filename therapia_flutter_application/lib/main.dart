import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapia_flutter_application/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:therapia_flutter_application/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:therapia_flutter_application/navigation/app_router.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>(),
        ),
        BlocProvider(create: (_) => di.sl<UserManagerBloc>()),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Therapeia',
            routerConfig: di.sl<AppRouter>().router,
          );
        },
      ),
    );
  }
}
