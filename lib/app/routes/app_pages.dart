// ignore_for_file: constant_identifier_names

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ticker_assign/app/bindings/home_bindings.dart';
import 'package:ticker_assign/app/bindings/transcript_bindings.dart';
import 'package:ticker_assign/app/modules/home/views/components/transcript_view.dart';
import 'package:ticker_assign/app/modules/home/views/home_view.dart';


/// A class that defines the routes for the app.
class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TRANSCRIPT,
      page: () => const TranscriptView(),
      binding: TranscriptBinding(),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/home';
  static const TRANSCRIPT = '/transcript';
}