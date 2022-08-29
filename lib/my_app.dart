import 'package:applocation/constants/const_colors.dart';
import 'package:applocation/core/logger/application_logger.dart';
import 'package:applocation/core/navigation_state/navigator_service.dart';
import 'package:applocation/modules/debug_view/pages/custom_error_view.dart';
import 'package:applocation/modules/debug_view/pages/view_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/bindings/application_bindings.dart';
import 'lang/translation_service.dart';
import 'routes/app_pages.dart';
import 'themes/theme_appview.dart';
import 'themes/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
       textDirection: TextDirection.ltr,
      child: Stack(
        
        children: [
          GetMaterialApp(
            initialBinding: ApplicationBindings(),
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.topLevel,
            enableLog: true,
            logWriterCallback: ApplicationLogger.write,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            locale: TranslationService.locale,
            fallbackLocale: TranslationService.fallbackLocale,
            translations: TranslationService(),
            localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
            supportedLocales: [const Locale("pt", "BR"), const Locale("es", "ES"), const Locale("en", "US")],
            title: 'nameApp'.tr,
            theme: Themes().lightTheme,
            darkTheme: Themes().darkTheme,
            themeMode: ThemeService().getThemeMode(),
            builder: (BuildContext context, Widget? widget) {
              ErrorWidget.builder = (FlutterErrorDetails details) {
                return CustomErrorView(details: details);
              };
              return widget!;
            },
          ),
          Positioned(
                  right: 100,
                  top: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: ConstColors.orange.withOpacity(0.25),
                      onPressed: () => Get.to(() => ViewLogs()),
                      child: Icon(Icons.build, color:ConstColors.orange.withOpacity(0.25)),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
