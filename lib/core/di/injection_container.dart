import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mst_test/features/main_screen/data/repositories/subscription_repository_impl.dart';
import '../../features/main_screen/domain/repositories/subscription_repository.dart';
import '../../features/main_screen/domain/usecases/check_subscription.dart';
import '../../features/main_screen/domain/usecases/set_subscription.dart';
import '../../features/main_screen/presentation/bloc/subscription_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  
  // Features - Main Screen
  sl.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(sharedPreferences: sl()),
  );
  
  sl.registerLazySingleton(() => CheckSubscription(sl()));
  sl.registerLazySingleton(() => SetSubscription(sl()));
  
  sl.registerFactory(
    () => SubscriptionBloc(
      checkSubscription: sl(),
      setSubscription: sl(),
    ),
  );
}