import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_subscription.dart';
import '../../domain/usecases/set_subscription.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final CheckSubscription checkSubscription;
  final SetSubscription setSubscription;
  
  SubscriptionBloc({
    required this.checkSubscription,
    required this.setSubscription,
  }) : super(SubscriptionInitial()) {
    on<CheckSubscriptionStatus>(_onCheckSubscriptionStatus);
    on<ActivateSubscription>(_onActivateSubscription);
    on<DeactivateSubscription>(_onDeactivateSubscription);
  }
  
  Future<void> _onCheckSubscriptionStatus(
    CheckSubscriptionStatus event,
    Emitter<SubscriptionState> emit,
  ) async {
    final isActive = await checkSubscription.call();
    if (isActive) {
      emit(SubscriptionActive());
    } else {
      emit(SubscriptionInactive());
    }
  }
  
  Future<void> _onActivateSubscription(
    ActivateSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    await setSubscription.call(true);
    emit(SubscriptionActive());
  }
  
  Future<void> _onDeactivateSubscription(
    DeactivateSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    await setSubscription.call(false);
    emit(SubscriptionInactive());
  }
}