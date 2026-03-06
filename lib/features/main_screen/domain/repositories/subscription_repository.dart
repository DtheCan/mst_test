abstract class SubscriptionRepository {
  Future<bool> checkSubscription();
  Future<void> setSubscription(bool isActive);
  Future<void> clearSubscription();
}