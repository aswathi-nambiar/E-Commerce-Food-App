import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'food_item_card.dart';

import '../../providers/product_provider.dart';

/// This class the list of all the items shown in the HomePage
class FoodItemListPage extends StatefulWidget {
  const FoodItemListPage({super.key});

  @override
  State<FoodItemListPage> createState() => _FoodItemListPageState();
}

class _FoodItemListPageState extends State<FoodItemListPage> {
  ProductProvider? productProvider;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchStarters();
    productProvider.fetchMainCourseDishesData();
    productProvider.fetchDessertData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context, listen: true);

    return ListView(
      children: [
        /// Starters
        FoodItemCardView(
          foodCategoryName: 'Starters',
          productList: productProvider!.getStartersDataList,
        ),

        /// Main Course
        FoodItemCardView(
          foodCategoryName: 'Main Course',
          productList: productProvider!.getMainCourseDataList,
        ),

        /// Dessert
        FoodItemCardView(
          foodCategoryName: 'Dessert',
          productList: productProvider!.getDessertDataList,
        ),
      ],
    );
  }
}
