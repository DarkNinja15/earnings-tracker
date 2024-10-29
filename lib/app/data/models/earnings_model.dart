class EarningsData {
  final String pricedate;
  final String ticker;
  final double actualEPS;
  final double estimatedEPS;
  final int actualRevenue;
  final int estimatedRevenue;

  EarningsData({
    required this.pricedate,
    required this.ticker,
    required this.actualEPS,
    required this.estimatedEPS,
    required this.actualRevenue,
    required this.estimatedRevenue,
  });

  factory EarningsData.fromJson(Map<String, dynamic> json) {
    return EarningsData(
      pricedate: json['pricedate'],
      ticker: json['ticker'],
      actualEPS: json['actual_eps']?.toDouble() ?? 0.0,
      estimatedEPS: json['estimated_eps']?.toDouble() ?? 0.0,
      actualRevenue: json['actual_revenue'] ?? 0,
      estimatedRevenue: json['estimated_revenue'] ?? 0,
    );
  }

  DateTime get date => DateTime.parse(pricedate);
}