import 'package:e_commerce_food_app/screens/review_cart/review_cart.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';

import '../favourites/favourites.dart';
import 'food_item_list.dart';

///[HomePage] is the homepage of the application. This  page
///has two tabs.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Favourites',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: CupertinoColors.systemYellow,
                leading: index == 0
                    ? _buildPageTitle('Home Page')
                    : _buildPageTitle('Favourites'),
                trailing: GestureDetector(
                  child: Icon(
                    CupertinoIcons.cart,
                    color: black,
                    size: 25.0,
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                          builder: (context) => const ReviewCart()),
                    );
                  },
                ),
              ),
              child: SafeArea(
                child: index == 0
                    ? const FoodItemListPage()
                    : const FavouriteList(),
              ),
            );
          },
        );
      },
    );
  }

  /// This function build the widget showing the title in the appbar
  Widget _buildPageTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 5.0,
      ),
      child: Text(title),
    );
  }
}
