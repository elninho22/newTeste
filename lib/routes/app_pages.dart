

import 'package:applocation/modules/debug_view/pages/view_logs.dart';
import 'package:applocation/modules/home/bindings/appview_bindings.dart';
import 'package:applocation/modules/home/presenter/appview_widget.dart';
import 'package:applocation/modules/home/presenter/pages/appview_itens.dart';
import 'package:applocation/modules/splash/bindings/splash_bindings.dart';
import 'package:applocation/modules/splash/presenter/splash_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => const SplashScreen(), binding: SplashBindings()),
    GetPage(name: Routes.PAGE_HOME, page: () => const AppViewScreen(), binding: AppViewBindings()),
    GetPage(name: Routes.PAGE_LOGS, page: () => const ViewLogs()),
    GetPage(name: Routes.PAGE_ITENS, page: () => const AppViewItens()),
  ];
}
