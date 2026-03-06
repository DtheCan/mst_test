import 'package:equatable/equatable.dart';
import '../repositories/subscription_repository.dart';

class CheckSubscription extends Equatable {
  final SubscriptionRepository repository;
  
  const CheckSubscription(this.repository);
  
  Future<bool> call() async {
    return await repository.checkSubscription();
  }
  
  @override
  List<Object?> get props => [repository];
}