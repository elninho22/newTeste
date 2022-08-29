import 'dart:async';
import 'dart:io';

import 'package:applocation/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  FlutterError.onError = (FlutterErrorDetails details) => FlutterError.dumpErrorToConsole(details);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runZonedGuarded(() {
    runApp(const MyAppInit());
  }, (e, s) {
    debugPrint(e.toString());
  });
}

class MyAppInit extends StatelessWidget {
  const MyAppInit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Visibility(
      visible: kDebugMode,
      child: MyApp(),
    );
  }
}
