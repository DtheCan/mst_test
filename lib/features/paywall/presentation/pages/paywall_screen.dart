import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main_screen/presentation/bloc/subscription_bloc.dart';
import '../widgets/subscription_plan_card.dart';
import '../../domain/entities/subscription_plan.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  String? _selectedPlanId;
  
  final List<SubscriptionPlan> _plans = [
    const SubscriptionPlan(
      id: 'monthly',
      title: 'Месячная подписка',
      price: '9.99',
      period: 'месяц',
    ),
    const SubscriptionPlan(
      id: 'yearly',
      title: 'Годовая подписка',
      price: '69.99',
      period: 'год',
      isPopular: true,
      discount: 42, // 42% экономии
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Center(
                child: Text(
                  'Премиум доступ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Выберите план подписки',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ..._plans.map((plan) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SubscriptionPlanCard(
                  plan: plan,
                  isSelected: _selectedPlanId == plan.id,
                  onTap: () {
                    setState(() {
                      _selectedPlanId = plan.id;
                    });
                  },
                ),
              )),
              const Spacer(),
              ElevatedButton(
                onPressed: _selectedPlanId == null
                    ? null
                    : () {
                        // Эмуляция покупки
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Подписка "${_selectedPlanId == 'monthly' ? 'Месячная' : 'Годовая'}" оформлена!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        
                        // Активация подписки
                        context.read<SubscriptionBloc>().add(ActivateSubscription());
                        
                        // Переход на главный экран
                        Navigator.of(context).pushReplacementNamed('/main');
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Продолжить',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Восстановление покупок (эмуляция)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Восстановление покупок...'),
                      ),
                    );
                  },
                  child: const Text(
                    'Восстановить покупки',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}