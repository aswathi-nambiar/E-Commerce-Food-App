import 'package:e_commerce_food_app/common_widgets/count.dart';
import 'package:e_commerce_food_app/models/product_model.dart';
import 'package:e_commerce_food_app/providers/favourites_provider.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// This class shows the details page of the dish
class ProductDetailPage extends StatefulWidget {
  final ProductModel? productData;

  const ProductDetailPage({
    super.key,
    required this.productData,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool wishListBool = false;
  FavoritesProvider? wishListProvider;

  @override
  void initState() {
    super.initState();

    getInitialData();
  }

  getInitialData() async {
    FavoritesProvider wishListProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    wishListBool = await wishListProvider
        .getWishListBool(widget.productData?.productId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    FavoritesProvider wishListProvider =
        Provider.of<FavoritesProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemYellow,
          middle: const Text('View Details'),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Icon(
              CupertinoIcons.back,
              color: CupertinoColors.black,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    /// Product Image
                    Container(
                        height: MediaQuery.of(context).size.height / 2,
                        padding: const EdgeInsets.only(top: 40, bottom: 40.0),
                        child: Image.network(
                          widget.productData?.productImage ?? "",
                        )),

                    /// Widget showing the information like veg/non veg dish and bestseller etc.
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 20.0,
                            child: Image(
                                image: (widget.productData?.isVegDish != null &&
                                        widget.productData?.isVegDish == true)
                                    ? const AssetImage(
                                        'assets/veg.png',
                                      )
                                    : const AssetImage('assets/non_veg.png')),
                          ),
                        ),
                        Visibility(
                          visible: widget.productData?.isBestseller == true,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
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

                    /// Widget showing the product name and favorite icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.productData?.productName ?? '',
                            style: dishCatergoryNameDetailsTextStyle,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child:

                              /// add to favorite
                              CupertinoButton(
                            child: Icon(wishListBool == false
                                ? CupertinoIcons.heart
                                : CupertinoIcons.heart_solid),
                            onPressed: () {
                              // Perform the "like" action
                              setState(() {
                                wishListBool = !wishListBool;
                              });
                              if (wishListBool == true) {
                                wishListProvider.addWishListData(
                                  productData: widget.productData,
                                );
                              } else {
                                wishListProvider.deleteWishList(
                                    widget.productData?.productId);
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    /// Widget showing the product description
                    Text(widget.productData?.productDescription ?? ''),
                    const SizedBox(
                      height: 20.0,
                    ),

                    /// Widget showing other details like price and whether
                    /// veg/non veg dish
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "$currencySymbol${widget.productData?.productPrice}"),
                        Count(
                          showGoToCartButton: true,
                          productId: widget.productData?.productId,
                          productImage: widget.productData?.productImage,
                          productName: widget.productData?.productName,
                          productPrice: widget.productData?.productPrice,
                          productUnit: widget.productData?.productUnit,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
