import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ticker_assign/app/bindings/home_bindings.dart';
import 'package:ticker_assign/app/modules/home/views/home_view.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/home';
}