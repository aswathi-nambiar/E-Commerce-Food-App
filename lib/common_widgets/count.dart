import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/review_cart_model.dart';
import '../providers/review_cart_provider.dart';
import '../screens/review_cart/review_cart.dart';
import '../utils/colors.dart';
import 'common_alert.dart';

/// This class is responsible for adding and removing the dish
/// from cart
class Count extends StatefulWidget {
  final bool? showGoToCartButton;
  final bool isSearch;
  final String? productName;
  final String? productImage;
  final String? productId;
  final int? productPrice;
  final dynamic productUnit;

  const Count(
      {this.showGoToCartButton = false,
      this.isSearch = false,
      this.productName,
      this.productUnit,
      this.productId,
      this.productImage,
      this.productPrice,
      super.key});
  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;
  ValueNotifier<String> changeOnValue = ValueNotifier("");

  @override
  void initState() {
    super.initState();
    getAddAndQuantity();
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: true);

    return Selector<ReviewCartProvider, List<ReviewCartModel?>>(
        selector: (_, model) => model.getReviewCartDataList,
        builder: (_, text, __) {
          return Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: greyColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: isTrue == true

                    /// When the dish is already added to cart, below widget shows the + and - icon
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (count == 1) {
                                setState(() {
                                  isTrue = false;
                                  changeOnValue.value = 'false';
                                });
                                reviewCartProvider
                                    .reviewCartDataDelete(widget.productId);
                              } else if (count > 1) {
                                setState(() {
                                  count--;
                                });
                                reviewCartProvider.updateReviewCartData(
                                  cartId: widget.productId,
                                  cartImage: widget.productImage,
                                  cartName: widget.productName,
                                  cartPrice: widget.productPrice,
                                  cartQuantity: count,
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(widget.isSearch ? 3 : 0),
                              child: const Icon(
                                CupertinoIcons.minus,
                                size: 20,
                                color: Color(0xffd0b84c),
                              ),
                            ),
                          ),
                          Text(
                            " $count ",
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (count < 10) {
                                setState(() {
                                  count++;
                                });
                              } else {
                                await showCupertinoDialog(
                                    context: context,
                                    builder: (_) => const CommonAlertDialog(
                                          title: 'Add another Dish',
                                          content:
                                              'You have added your maximum limit. Kindly add another dish.',
                                          showNegativeActionButton: false,
                                          positiveActionButtonName: 'OK',
                                        ));
                              }

                              reviewCartProvider.updateReviewCartData(
                                cartId: widget.productId,
                                cartImage: widget.productImage,
                                cartName: widget.productName,
                                cartPrice: widget.productPrice,
                                cartQuantity: count,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(widget.isSearch ? 3 : 0),
                              child: const Icon(
                                CupertinoIcons.add,
                                size: 20,
                                color: Color(0xffd0b84c),
                              ),
                            ),
                          ),
                        ],
                      )

                    /// When the dish is not added to cart, below widget shows the ADD button
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isTrue = true;
                              changeOnValue.value = 'true';
                            });
                            reviewCartProvider.addReviewCartData(
                              cartId: widget.productId,
                              cartImage: widget.productImage,
                              cartName: widget.productName,
                              cartPrice: widget.productPrice,
                              cartQuantity: count,
                              cartUnit: widget.productUnit,
                            );
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                width: 15.0,
              ),

              /// Go to Cart Button
              Visibility(
                visible: (widget.showGoToCartButton == true && isTrue == true),
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  color: primaryColor,
                  onPressed: () async {
                    bool refreshData =
                        await Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                          builder: (context) => const ReviewCart()),
                    );
                    if (refreshData) {
                      getAddAndQuantity();
                    }
                  },
                  child: const Text('Go to Cart'),
                ),
              ),
            ],
          );
        });
  }

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (value.exists)
              {
                setState(() {
                  count = value.get("cartQuantity");
                  isTrue = value.get("isAdd");
                })
              }
            else
              {
                setState(() {
                  isTrue = false;
                })
              }
          },
        );
  }
}
