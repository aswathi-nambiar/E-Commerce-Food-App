import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import '../../models/product_model.dart';
import '../../utils/constants.dart';

/// This class shows the individual items information showed in the homepage
class ProductInformation extends StatelessWidget {
  final ProductModel? productData;

  final Function() onTap;

  const ProductInformation({
    super.key,
    this.productData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            height: 230,
            width: 165,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(blurRadius: 5.0, color: greyColor)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Widget handling the Product Image
                    Expanded(
                      flex: 4,

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 200,
                        padding: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: Image.network(
                          productData?.productImage ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // ),
                    ),

                    /// Widget handling the Product name, price, quantity and count button
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Widget showing the product name
                            Text(
                              productData?.productName ?? '',
                              style: dishNameTextStyle1,
                            ),

                            /// Widget showing the price and quantity
                            Text(
                                '$currencySymbol ${productData?.productPrice}/${productData?.productUnit ?? 0}',
                                style: priceTextStyle),
                            const SizedBox(
                              height: 5,
                            ),

                            /// Widget showing the information like veg/non veg dish and bestseller etc.
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: 20.0,
                                    child: Image(
                                        image: (productData?.isVegDish !=
                                                    null &&
                                                productData?.isVegDish == true)
                                            ? const AssetImage(
                                                'assets/veg.png',
                                              )
                                            : const AssetImage(
                                                'assets/non_veg.png')),
                                  ),
                                ),

                                /// Widget showing whether bestseller dish
                                Visibility(
                                  visible: productData?.isBestseller == true,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: orangeColor,
                                    ),
                                    child: Text(
                                      'Bestseller',
                                      style: bestSellerTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
