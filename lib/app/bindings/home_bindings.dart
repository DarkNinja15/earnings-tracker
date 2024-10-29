import 'package:get/get.dart';
import 'package:ticker_assign/app/data/providers/api_provider.dart';
import 'package:ticker_assign/app/data/repositories/earnings_repository.dart';
import 'package:ticker_assign/app/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => EarningsRepository(apiProvider: Get.find()));
    Get.lazyPut(() => HomeController(repository: Get.find()));
  }
}