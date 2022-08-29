import 'package:applocation/core/responsive/orientation_layout.dart';
import 'package:applocation/core/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';

import 'pages/appview_phone.dart';

class AppViewScreen extends StatelessWidget {
  const AppViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => const AppViewPhone(),
        landscape: (context) => const AppViewPhone(),
      ),
      tablet: const AppViewPhone(),
      desktop: const AppViewPhone(),
    );
  }
}
