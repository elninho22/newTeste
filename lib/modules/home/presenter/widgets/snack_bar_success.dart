import 'package:applocation/constants/const_colors.dart';
import 'package:applocation/core/navigation_state/navigator_service.dart';
import 'package:applocation/lang/app_translation.dart';
import 'package:flutter/material.dart';


SnackBar snackBarSuccess({String text = 'sucess_network'}) => SnackBar(
      backgroundColor:ConstColors.orange,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      content: Text(
        AppTranslationString.string(text),
        style: Theme.of(NavigatorService.navigatorKey.currentContext!).textTheme.titleMedium?.copyWith(
              color: ConstColors.orange,
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
            ),
        textAlign: TextAlign.center,
      ),
    );

SnackBar snackBarWarning({String text = 'failure_network'}) => SnackBar(
      backgroundColor: ConstColors.orange,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      content: Text(
        AppTranslationString.string(text),
        style: Theme.of(NavigatorService.navigatorKey.currentContext!).textTheme.titleMedium?.copyWith(
              color: ConstColors.orange,
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
            ),
        textAlign: TextAlign.center,
      ),
    );
