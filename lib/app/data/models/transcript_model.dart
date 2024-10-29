class TranscriptData {
  final String symbol;
  final String transcript;
  final DateTime date;

  TranscriptData({
    required this.symbol,
    required this.transcript,
    required this.date,
  });

  factory TranscriptData.fromJson(Map<String, dynamic> json) {
    return TranscriptData(
      symbol: json['symbol'],
      transcript: json['transcript'],
      date: DateTime.parse(json['date']),
    );
  }
}