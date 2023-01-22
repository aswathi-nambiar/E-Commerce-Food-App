import 'package:e_commerce_food_app/common_widgets/common_alert.dart';
import 'package:e_commerce_food_app/common_widgets/single_item.dart';
import 'package:e_commerce_food_app/models/product_model.dart';
import 'package:e_commerce_food_app/providers/favourites_provider.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// This page shows the items added as the favorites
class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key});

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  FavoritesProvider? wishListProvider;

  @override
  void initState() {
    wishListProvider = Provider.of(context, listen: false);
    wishListProvider?.getFavoritesListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FavoritesProvider, List<ProductModel>>(
        selector: (_, model) => model.getWishList,
        builder: (_, text, __) {
          /// Widget having the information of the dishes wishlisted
          return wishListProvider!.getWishList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NO FAVOURITES FOUND",
                        style: cartEmptyMessageStyle,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Icon(
                        CupertinoIcons.heart,
                        color: greyColor,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: wishListProvider?.getWishList.length,
                  itemBuilder: (context, index) {
                    ProductModel? data = wishListProvider?.getWishList[index];
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SingleItem(
                          showDeleteButton: true,
                          wishList: true,
                          productData: data,
                          productImage: data?.productImage,
                          productName: data?.productName ?? '',
                          productPrice: data?.productPrice ?? 0,
                          productId: data?.productId ?? '',
                          productQuantity: data?.productQuantity ?? 0,
                          onDelete: () async {
                            await showCupertinoDialog(
                                context: context,
                                builder: (_) => CommonAlertDialog(
                                      title: 'WishList Product',
                                      content:
                                          'Do you want to Delete the product?',
                                      onPositiveAction: () =>
                                          _deleteItemFromWishList(
                                              data?.productId ?? ''),
                                    ));
                          },
                        ),
                      ],
                    );
                  },
                );
        });
  }

  /// This called when a dish is removed from the favorites
  _deleteItemFromWishList(String productId) {
    wishListProvider?.deleteWishList(productId);
  }
}
