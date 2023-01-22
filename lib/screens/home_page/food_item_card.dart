import 'package:flutter/cupertino.dart';
import '../../models/product_model.dart';
import '../product_details.dart';
import '../search/search.dart';
import '../../utils/constants.dart';
import 'package:e_commerce_food_app/screens/home_page/product_information.dart';

/// This class shows the card carousal in the Home Page for each categories

class FoodItemCardView extends StatelessWidget {
  final String foodCategoryName;
  final List<ProductModel?> productList;
  const FoodItemCardView(
      {required this.foodCategoryName, required this.productList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  foodCategoryName,
                  style: dishCatergoryNameTextStyle,
                ),

                /// Widget navigating to the search page
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (context) => SearchPage(
                          search: productList,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'view all',
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                ),
              ],
            ),
          ),

          /// Widget handling the horizontal swiping card showing the dish details
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productList.map(
                (herbsProductData) {
                  return ProductInformation(
                    onTap: () =>
                        Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (context) => ProductDetailPage(
                          productData: herbsProductData,
                        ),
                      ),
                    ),
                    productData: herbsProductData,
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
