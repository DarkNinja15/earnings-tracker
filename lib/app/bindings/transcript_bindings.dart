import 'package:get/get.dart';
import 'package:ticker_assign/app/modules/home/controller/transcript_controller.dart';


/// A binding class for the transcript view.
class TranscriptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TranscriptController(repository: Get.find()));
  }
}