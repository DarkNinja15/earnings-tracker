import 'package:ticker_assign/app/data/models/earnings_model.dart';
import 'package:ticker_assign/app/data/models/transcript_model.dart';
import 'package:ticker_assign/app/data/providers/api_provider.dart';

class EarningsRepository {
  final ApiProvider apiProvider;

  EarningsRepository({required this.apiProvider});

  Future<List<EarningsData>> getEarningsData(String symbol) =>
      apiProvider.getEarningsData(symbol);

  Future<TranscriptData> getTranscript(String symbol, int year, int quarter) =>
      apiProvider.getTranscript(symbol, year, quarter);
}