import 'package:get/get.dart';
import '../../../data/models/transcript_model.dart';
import '../../../data/repositories/earnings_repository.dart';

class TranscriptController extends GetxController {
  final EarningsRepository repository;
  final transcript = Rx<TranscriptData>(TranscriptData(transcript: ''));
  final isLoading = false.obs;
  final error = ''.obs;

  TranscriptController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    fetchTranscript();
  }

  Future<void> fetchTranscript() async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final ticker = Get.arguments['ticker'];
      final year = Get.arguments['year'];
      final quarter = Get.arguments['quarter'];
      
      transcript.value = await repository.getTranscript(ticker, year, quarter);
    } catch (e) {
      error.value = 'Failed to load transcript. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}