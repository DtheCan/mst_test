import 'package:equatable/equatable.dart';
import '../repositories/subscription_repository.dart';

class SetSubscription extends Equatable {
  final SubscriptionRepository repository;
  
  const SetSubscription(this.repository);
  
  Future<void> call(bool isActive) async {
    await repository.setSubscription(isActive);
  }
  
  @override
  List<Object?> get props => [repository];
}