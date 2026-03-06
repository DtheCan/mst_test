import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mst_test/core/di/injection_container.dart';
import 'package:mst_test/features/main_screen/presentation/bloc/subscription_bloc.dart';
import 'package:mst_test/features/main_screen/presentation/pages/main_screen.dart';
import 'package:mst_test/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:mst_test/features/paywall/presentation/pages/paywall_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SubscriptionBloc>(
          create: (context) => sl<SubscriptionBloc>()..add(CheckSubscriptionStatus()),
        ),
      ],
      child: MaterialApp(
        title: 'Subscription App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => BlocBuilder<SubscriptionBloc, SubscriptionState>(
                builder: (context, state) {
                  if (state is SubscriptionActive) {
                    return const MainScreen();
                  } else if (state is SubscriptionInactive) {
                    return const OnboardingScreen();
                  }
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
          '/onboarding': (context) => const OnboardingScreen(),
          '/paywall': (context) => const PaywallScreen(),
          '/main': (context) => const MainScreen(),
        },
      ),
    );
  }
}