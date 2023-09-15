import 'package:flutter/cupertino.dart';

import '../../common/constants/ui_constants.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // setting background gif animation
        Positioned.fill(
            child: Image.asset("assets/background.gif",
                fit: BoxFit.cover)),

        // showing loading indicator
        const Center(child: customLoadingIndicator),
      ],
    );
  }
}
