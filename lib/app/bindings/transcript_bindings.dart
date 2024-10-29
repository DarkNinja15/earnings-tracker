import 'package:get/get.dart';
import 'package:ticker_assign/app/modules/home/controller/transcript_controller.dart';

class TranscriptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TranscriptController(repository: Get.find()));
  }
}