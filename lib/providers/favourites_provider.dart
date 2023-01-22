import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

/// This is the Provider class for the favorites.
class FavoritesProvider with ChangeNotifier {
  /// This function will add  marked product to YourWishList document in firebase
  addWishListData({
    ProductModel? productData,
  }) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(productData?.productId)
        .set({
      "wishListId": productData?.productId,
      "wishListName": productData?.productName,
      "wishListImage": productData?.productImage,
      "wishListPrice": productData?.productPrice,
      "wishList": true,
      "isBestseller": productData?.isBestseller,
      "isVegDish": productData?.isVegDish,
      "productDescription": productData?.productDescription,
    });
    getFavoritesListData();
  }

  /// This field will have the list of all favorite items
  List<ProductModel> favoritesList = [];

  /// This function gets all the favorites from Firebase.
  getFavoritesListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .get();
    for (var element in value.docs) {
      ProductModel productModel = ProductModel(
        productId: element.get("wishListId"),
        productImage: element.get("wishListImage"),
        productName: element.get("wishListName"),
        productPrice: element.get("wishListPrice"),
        isBestseller: element.get("isBestseller"),
        isVegDish: element.get("isVegDish"),
        productDescription: element.get("productDescription"),
        // productQuantity: element.get("wishListQuantity"),
      );
      newList.add(productModel);
    }
    favoritesList = newList;
    notifyListeners();
  }

  /// This getter return the favorite list
  List<ProductModel> get getWishList {
    return favoritesList;
  }

  /// This function deletes a particular from the favorites document in Firebase.
  deleteWishList(wishListId) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .delete();
    getFavoritesListData();
  }

  /// This function returns [bool] value- if the product is already favourite then
  /// it return true else false
  bool getWishListBool(String productId) {
    bool isWishListed = false;
    for (var element in getWishList) {
      if (element.productId == productId) {
        isWishListed = true;
        continue;
      }
    }
    return isWishListed;
  }
}
