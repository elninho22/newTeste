import 'package:applocation/constants/const_drawables.dart';
import 'package:applocation/modules/design_system/style/style_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../lang/app_translation.dart';



class CustomErrorView extends StatelessWidget {
  final FlutterErrorDetails? details;
  const CustomErrorView({Key? key, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(ConstDrawables.image404),
              Text(
                kDebugMode ? details?.summary.toString() ?? AppTranslationString.string('failure_aplication') : AppTranslationString.string('failure_aplication'),
                textAlign: TextAlign.center,
                style: StyleApp.caption,
              ),
              Visibility(
                visible: kDebugMode,
                replacement: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    AppTranslationString.string('failure_aplication'),
                    style: StyleApp.caption,
                  ),
                ),
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
