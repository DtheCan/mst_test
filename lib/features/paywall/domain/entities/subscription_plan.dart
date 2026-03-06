class SubscriptionPlan {
  final String id;
  final String title;
  final String price;
  final String period;
  final bool isPopular;
  final double? discount;
  
  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.price,
    required this.period,
    this.isPopular = false,
    this.discount,
  });
}