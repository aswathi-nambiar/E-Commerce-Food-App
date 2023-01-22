import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';

/// This class return shows indicator
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: Center(
        child: CupertinoActivityIndicator(radius: 20.0, color: greenColor),
      ),
    );
  }
}
