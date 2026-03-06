class Subscription {
  final bool isActive;
  final DateTime? expiryDate;
  
  const Subscription({
    required this.isActive,
    this.expiryDate,
  });
}