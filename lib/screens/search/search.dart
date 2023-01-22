import 'package:e_commerce_food_app/common_widgets/single_item.dart';
import 'package:e_commerce_food_app/models/product_model.dart';
import 'package:flutter/cupertino.dart';

/// This class shows the Search page
class SearchPage extends StatefulWidget {
  /// this field has the list of dishes
  /// from the selected category
  final List<ProductModel?> search;
  const SearchPage({super.key, required this.search});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductModel?> searchItem = [];
  TextEditingController controller = TextEditingController();

  /// This function is used to perform the search
  _performSearch() {
    if (widget.search.isNotEmpty) {
      List<ProductModel?> searchFood = widget.search.where((element) {
        if (element != null && element.productName != null) {
          return element.productName!.toLowerCase().contains(controller.text);
        } else {
          return false;
        }
      }).toList();
      return searchFood;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    searchItem = _performSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemYellow,
          middle: const Text('Find your Favourite Dish'),
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
        child: ListView(
          children: [
            /// Search bar
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CupertinoSearchTextField(
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    searchItem = _performSearch();
                  });
                },
                onSubmitted: (value) {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: searchItem.map((data) {
                return SingleItem(
                  showDeleteButton: false,
                  productImage: data?.productImage,
                  productName: data?.productName ?? '',
                  productPrice: data?.productPrice ?? 0,
                  productQuantity: data?.productQuantity ?? 0,
                  productId: data?.productId ?? '',
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
