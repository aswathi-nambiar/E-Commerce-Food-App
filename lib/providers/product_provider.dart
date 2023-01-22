import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

/// This is the provider class for Dishes
class ProductProvider with ChangeNotifier {
  ProductModel? productModel;

  List<ProductModel?> search = [];

  getProductInformation(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
      productUnit: element.get("productUnit"),
      isBestseller: element.get("isBestseller"),
      isVegDish: element.get("isVegDish"),
      productDescription: element.get("productDescription"),
    );
    search.add(productModel);
  }

  /// This field consists of all the starters
  List<ProductModel?> startersList = [];

  /// This function fetch details of the starters from Firebase
  fetchStarters() async {
    List<ProductModel?> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Starters").get();

    for (var element in value.docs) {
      getProductInformation(element);

      newList.add(productModel);
    }
    startersList = newList;
    notifyListeners();
  }

  /// This is a getter returning all the starters list
  List<ProductModel?> get getStartersDataList {
    return startersList;
  }

  /// This field consists of all the main course items
  List<ProductModel?> mainCourseDishes = [];

  /// This function fetch details of the main course from Firebase
  fetchMainCourseDishesData() async {
    List<ProductModel?> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("MainCourseDishes").get();

    for (var element in value.docs) {
      getProductInformation(element);
      newList.add(productModel);
    }
    mainCourseDishes = newList;
    notifyListeners();
  }

  /// This is a getter returning all the main course list
  List<ProductModel?> get getMainCourseDataList {
    return mainCourseDishes;
  }

  /// This is a getter returning all the dessert list
  List<ProductModel?> dessertDataList = [];

  /// This function fetch details of the dessert from Firebase
  fetchDessertData() async {
    List<ProductModel?> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("DessertDishes").get();

    for (var element in value.docs) {
      getProductInformation(element);
      newList.add(productModel);
    }
    dessertDataList = newList;
    notifyListeners();
  }

  /// This is a getter returning all the dessert list
  List<ProductModel?> get getDessertDataList {
    return dessertDataList;
  }

  /////////////////// Search Return ////////////
  List<ProductModel?> get gerAllProductSearch {
    return search;
  }
}
