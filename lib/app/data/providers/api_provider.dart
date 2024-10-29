import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ticker_assign/app/data/models/earnings_model.dart';
import 'package:ticker_assign/app/data/models/transcript_model.dart';

class ApiProvider {
  static const String baseUrl = 'https://api.api-ninjas.com/v1';
  static const String apiKey = 'YOUR_API_KEY';

  Future<List<EarningsData>> getEarningsData(String symbol) async {
    final response = await http.get(
      Uri.parse('$baseUrl/earningscalendar?ticker=$symbol'),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => EarningsData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load earnings data');
    }
  }

  // Future<TranscriptData> getTranscript(String symbol, DateTime date) async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/earningscalltranscript?symbol=$symbol&date=${date.toIso8601String()}'),
  //     headers: {'X-Api-Key': apiKey},
  //   );

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonData = json.decode(response.body);
  //     return TranscriptData.fromJson(jsonData);
  //   } else {
  //     throw Exception('Failed to load transcript data');
  //   }
  // }

  Future<TranscriptData> getTranscript(String ticker, String date) async {
    final response = await http.get(
      Uri.parse('$baseUrl/earningscalltranscript?ticker=$ticker&date=$date'),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return TranscriptData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load transcript data');
    }
  }
}