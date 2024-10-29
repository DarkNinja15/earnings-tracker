import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticker_assign/app/data/models/earnings_model.dart';
import 'package:ticker_assign/app/data/models/transcript_model.dart';
import 'package:ticker_assign/app/data/repositories/earnings_repository.dart';

/// A controller for the home view.
class HomeController extends GetxController {
  final EarningsRepository repository;
  final FocusNode _focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    // do not open the keyboard when the page loads
    _focusNode.requestFocus();
  }
  
  HomeController({required this.repository});

  final symbol = ''.obs;
  final isLoading = false.obs;
  final earningsData = <EarningsData>[].obs;
  final selectedTranscript = Rxn<TranscriptData>();

  Future<void> fetchEarningsData(String tickerSymbol) async {
    try {
      isLoading.value = true;
      symbol.value = tickerSymbol;
      earningsData.value = await repository.getEarningsData(tickerSymbol);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch earnings data');
    } finally {
      isLoading.value = false;
    }
  }
}