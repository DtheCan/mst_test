part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
  
  @override
  List<Object?> get props => [];
}

class CheckSubscriptionStatus extends SubscriptionEvent {}

class ActivateSubscription extends SubscriptionEvent {}

class DeactivateSubscription extends SubscriptionEvent {}