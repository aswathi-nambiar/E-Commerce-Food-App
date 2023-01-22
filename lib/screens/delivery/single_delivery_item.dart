import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';

/// This is the widget showing the added delivery address
/// in the delivery details page
class SingleDeliveryItem extends StatelessWidget {
  final String title;
  final String address;
  final String number;
  final String addressType;

  const SingleDeliveryItem({
    super.key,
    required this.title,
    required this.addressType,
    required this.address,
    required this.number,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      addressType,
                      style: TextStyle(
                        fontSize: 13,
                        color: black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(address),
            ),
            Text(number),
            const SizedBox(
              height: 10.0,
            )
          ],
        ),
      ],
    );
  }
}
