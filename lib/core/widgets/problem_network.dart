import 'package:applocation/constants/const_colors.dart';
import 'package:flutter/material.dart';

import '../../lang/app_translation.dart';

class ProblemNetwork extends StatelessWidget {
  final void Function()? onPressed;
  const ProblemNetwork({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppTranslationString.string('failure_network'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: onPressed,
            icon: const Icon(
              Icons.network_locked_outlined,
              color: ConstColors.blue
            ),
            label: Text(
              AppTranslationString.string('Checar o sinal'),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          )
        ],
      ),
    );
  }
}
