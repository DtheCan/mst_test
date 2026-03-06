import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../../../core/constants/app_constants.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SharedPreferences sharedPreferences;
  
  SubscriptionRepositoryImpl({required this.sharedPreferences});
  
  @override
  Future<bool> checkSubscription() async {
    return sharedPreferences.getBool(AppConstants.subscriptionActive) ?? false;
  }
  
  @override
  Future<void> setSubscription(bool isActive) async {
    await sharedPreferences.setBool(AppConstants.subscriptionActive, isActive);
    if (isActive) {
      // Set expiry date to 30 days from now for monthly, 365 for yearly
      // For simplicity, we'll just set it to 30 days
      final expiryDate = DateTime.now().add(const Duration(days: 30));
      await sharedPreferences.setString(
        AppConstants.subscriptionExpiryDate,
        expiryDate.toIso8601String(),
      );
    } else {
      await sharedPreferences.remove(AppConstants.subscriptionExpiryDate);
    }
  }
  
  @override
  Future<void> clearSubscription() async {
    await sharedPreferences.remove(AppConstants.subscriptionActive);
    await sharedPreferences.remove(AppConstants.subscriptionExpiryDate);
  }
}