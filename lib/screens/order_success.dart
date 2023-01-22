import 'package:e_commerce_food_app/screens/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

/// This is the Success page which is shown on the successful placing of the order
class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Stack(fit: StackFit.passthrough, children: const [
              Image(
                image: AssetImage(
                  'assets/order_sucess_icon.png',
                ),
                height: 150.0,
              ),
            ]),
            Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        'Order placed successfully.',
                        style: orderSuccessMessageStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Your Order is getting prepared. Kindly go through rest of the items while we prepare your order',
                          style: orderSuccessSubMessageStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        color: greenColor,
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Browse other dishes'),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
