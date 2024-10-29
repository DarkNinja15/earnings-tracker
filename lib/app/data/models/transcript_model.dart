/// Transcript model
class TranscriptData {
  final String transcript;

  TranscriptData({
    required this.transcript,
  });

  factory TranscriptData.fromJson(Map<String, dynamic> json) {
    return TranscriptData(
      transcript: json['transcript'] ?? '',
    );
  }
}