import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/review_cart_provider.dart';
import '../screens/product_details.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'common_alert.dart';
import 'count.dart';

class SingleItem extends StatefulWidget {
  final bool showDeleteButton;
  final String? productImage;
  final String productName;
  final bool wishList;
  final int productPrice;
  final String productId;
  final int productQuantity;
  final Function()? onDelete;
  final dynamic productUnit;
  final ProductModel? productData;
  const SingleItem(
      {super.key,
      required this.productQuantity,
      required this.productId,
      this.productUnit,
      this.onDelete,
      this.showDeleteButton = false,
      this.productData,
      this.productImage,
      required this.productName,
      required this.productPrice,
      this.wishList = false});

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  ReviewCartProvider? reviewCartProvider;

  late int count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  @override
  void initState() {
    reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    getCount();
    reviewCartProvider?.getReviewCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              /// widget showing image and on click on the image
              /// the user is navigated to products details page.
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (widget.productData != null) {
                      Navigator.of(context, rootNavigator: true).push(
                        CupertinoPageRoute(
                          builder: (context) => ProductDetailPage(
                            productData: widget.productData,
                          ),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    height: 90,
                    child: Center(
                      child: Image.network(
                        widget.productImage ?? '',
                      ),
                    ),
                  ),
                ),
              ),

              /// Widget showing the product name, product price
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: widget.showDeleteButton == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            "$currencySymbol${reviewCartProvider?.getUpdatedProductPrice(widget.productPrice, count)}",
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Widget showing the add and delete button with item quantity
              Expanded(
                flex: 1,
                child: Container(
                  padding: widget.showDeleteButton == false
                      ? const EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      : const EdgeInsets.only(left: 15, right: 15),
                  child: widget.showDeleteButton == false
                      ? Count(
                          isSearch: widget.showDeleteButton,
                          productId: widget.productId,
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: widget.onDelete,
                                child: Icon(
                                  CupertinoIcons.delete,
                                  size: 30,
                                  color: black,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),

                              /// adding and reducing quantity widget is not shown
                              /// in wishlist page
                              Visibility(
                                visible: widget.wishList == false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: greyColor),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (count == 1) {
                                              await showCupertinoDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      const CommonAlertDialog(
                                                        title: 'Minimum Order',
                                                        content:
                                                            'You have reached the minimum limit for this dish.',
                                                        showNegativeActionButton:
                                                            false,
                                                        positiveActionButtonName:
                                                            'OK',
                                                      ));
                                            } else {
                                              count--;

                                              reviewCartProvider
                                                  ?.updateReviewCartData(
                                                cartImage: widget.productImage,
                                                cartId: widget.productId,
                                                cartName: widget.productName,
                                                cartPrice: widget.productPrice,
                                                cartQuantity: count,
                                              );
                                            }
                                          },
                                          child: Icon(
                                            CupertinoIcons.minus,
                                            color: primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          "$count",
                                          style: TextStyle(
                                            color: primaryColor,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (count < 10) {
                                              count++;

                                              reviewCartProvider
                                                  ?.updateReviewCartData(
                                                cartImage: widget.productImage,
                                                cartId: widget.productId,
                                                cartName: widget.productName,
                                                cartPrice: widget.productPrice,
                                                cartQuantity: count,
                                              );
                                            } else {
                                              await showCupertinoDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      const CommonAlertDialog(
                                                        title:
                                                            'Add another Dish',
                                                        content:
                                                            'You have added your maximum limit. Kindly add another dish.',
                                                        showNegativeActionButton:
                                                            false,
                                                        positiveActionButtonName:
                                                            'OK',
                                                      ));
                                            }
                                          },
                                          child: Icon(
                                            CupertinoIcons.add,
                                            color: primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
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
        ),
        Visibility(
          visible: widget.showDeleteButton == false,
          child: Container(
            height: 1,
            color: greyColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
