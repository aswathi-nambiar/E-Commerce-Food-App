import 'package:e_commerce_food_app/common_widgets/common_alert.dart';
import 'package:e_commerce_food_app/common_widgets/single_item.dart';
import 'package:e_commerce_food_app/models/review_cart_model.dart';
import 'package:e_commerce_food_app/providers/review_cart_provider.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../delivery/delivery_details_page.dart';

/// This page shows the cart view with the selected dishes and
/// it's count.
class ReviewCart extends StatefulWidget {
  const ReviewCart({super.key});

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  ReviewCartProvider? reviewCartProvider;

  @override
  void initState() {
    super.initState();
    reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    reviewCartProvider?.getReviewCartData();
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemYellow,
          middle: const Text('Review Cart'),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: CupertinoColors.black,
            ),
          ),
        ),
        child: reviewCartProvider!.getReviewCartDataList.isEmpty

            /// If the cart is empty: empty cart label is shown
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "EMPTY CART",
                      style: cartEmptyMessageStyle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Icon(
                      CupertinoIcons.shopping_cart,
                      color: greyColor,
                    ),
                  ],
                ),
              )
            : Consumer<ReviewCartProvider>(
                builder: (_, reviewCartProvider, __) {
                return Column(children: [
                  /// Widget showing the added dishes in the cart
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          reviewCartProvider.getReviewCartDataList.length,
                      itemBuilder: (context, index) {
                        ReviewCartModel? data =
                            reviewCartProvider.getReviewCartDataList[index];
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SingleItem(
                              showDeleteButton: true,
                              wishList: false,
                              productImage: data?.cartImage ?? '',
                              productName: data?.cartName ?? '',
                              productPrice: data?.cartPrice ?? 0,
                              productId: data?.cartId ?? '',
                              productQuantity: data?.cartQuantity ?? 0,
                              productUnit: data?.cartUnit ?? '',
                              onDelete: () async {
                                if (data != null) {
                                  await showCupertinoDialog(
                                      context: context,
                                      builder: (_) => CommonAlertDialog(
                                            title: 'Cart Products',
                                            content:
                                                'Do you want to Delete the product?',
                                            onPositiveAction: () =>
                                                _deleteItemFromCart(
                                                    data.cartId ?? ''),
                                          ));
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Widget showing the total price
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "$currencySymbol ${reviewCartProvider.getTotalPrice()}",
                              style: totalAmountStyle,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Total Amount',
                              style: totalAmountLabelStyle,
                            )
                          ],
                        )),

                        /// Widget showing Proceed to checkout button
                        Expanded(
                          flex: 2,
                          child: CupertinoButton(
                            color: primaryColor,
                            onPressed: () async {
                              if (reviewCartProvider
                                  .getReviewCartDataList.isEmpty) {
                                await showCupertinoDialog(
                                    context: context,
                                    builder: (_) => const CommonAlertDialog(
                                          title: 'Empty Cart',
                                          content: 'No Cart Data Found.',
                                          showNegativeActionButton: false,
                                          positiveActionButtonName: 'OK',
                                        ));
                              }
                              if (!mounted) return;
                              await Navigator.of(context, rootNavigator: true)
                                  .push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const DeliveryDetailsPage(),
                                ),
                              );
                            },
                            child: const Text("Proceed to Checkout"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]);
              }),
      ),
    );
  }

  /// This function is called when the items is deleted
  /// from the cart
  _deleteItemFromCart(String cartId) {
    reviewCartProvider?.reviewCartDataDelete(cartId);
  }
}
